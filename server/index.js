const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const MongoClient = require('mongodb').MongoClient;
const Book = require('./model/books');
const dbName = 'test';
const Wishlist = require('./model/wishlist');


const DB =
  "mongodb+srv://17atharva:JOqySfbRYe7AqcHd@cluster0.jpnacr5.mongodb.net/?retryWrites=true&w=majority";

const PORT =3000;
const app = express();
const client = new MongoClient(DB);

app.use(express.json());
app.use(authRouter);

MongoClient.connect(DB)

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log("Connection Failed");
    console.log(e);
  });


app.listen(PORT, () => {
  console.log(`Connected at port ${PORT}`);
});

app.get('/api/books', (req, res) => {
  Book.find()
    .then((books) => {
      res.json(books);
    })
    .catch((error) => {
      res.status(500).json({ error: 'Internal Server Error' });
    });
});

app.get('/api/books/search', async (req, res) => {
  const searchTerm = req.query.term; 
  const regexSearchTerm = searchTerm ? searchTerm.toString() : ''
  const db = client.db(dbName);
  const booksCollection = db.collection('books');

  booksCollection.find({ title: { $regex: regexSearchTerm, $options: 'i' } })
    .toArray((err, results) => {
      if (err) {
        console.error('Error searching books:', err);
        res.status(500).send('Internal Server Error');
        return;
      }

      res.json(results); 
    });
});

app.post('/api/wishlist',async (req, res) => {
  console.log(req.body);
  console.log(req.headers)
  const { userId, bookId, name, author, image, price } = req.body;
 
  const wishlistItem = new Wishlist({
    userId,
    bookId,
    name,
    author,
    image,
    price
  });

  await wishlistItem.save()
    .then(() => {
      console.log('Item added to wishlist:', wishlistItem);
      res.sendStatus(201);
    })
    .catch((error) => {
      console.error('Error adding item to wishlist:', error);
      res.sendStatus(500);
    });
});

app.get('/api/wishlist/:userId', async(req, res) => {
  const userId = req.params.userId;
try{
  let wishlist = await Wishlist.find({ userId }).exec();
  res.json(wishlist);
  }catch(e){
    console.log(e);
    res.status(500).json({ error: 'Failed to fetch wishlist items'});
  }
});
