const express = require('express');
const User = require("../model/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const authRouter = express.Router();
const Book = require("../model/books");


authRouter.post('/api/signup', async (req, res) => {
    try{
        const {email, password} = req.body;
        const existingUser = await User.findOne({email});
    if(existingUser){
        return res.status(400).json({msg : "User with same email already exists"});
    }

    const hashedpassword = await bcryptjs.hash(password,8);

    let user = new User({
        email,
        password: hashedpassword,
    })

    user = await user.save();
    res.json(user);
    }catch(e){
        console.log(e);
        res.status(500).json({msg: "Server Error"});
    }
    
});

authRouter.post('/api/signin', async (req, res) => {
    try{
        const {email, password} = req.body;
        const user = await User.findOne({email})
        if(!user){
            return res.status(400).json({msg: "User does not exist"});
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg: "Incorrect Password"});
        }
        const token = jwt. sign({id: user._id}, "passwordKey");
        res. json ({token, ...user._doc})
    }catch(e){
        console.log(e);
        res.status(500).json({msg: "Server Error"});
    }
});

authRouter.post('api/books', async  (req, res) =>{
    try{
        const {name, price, image, author} = req.body;
        const book = new Book({
            name,
            price,
            image,
            author
        })
        await book.save();
        res.json(book);
    }catch(e){
        console.log(e);
        res.status(500).json({msg: "Server Error"});
    }
});

authRouter.post('/api/logout', async (req, res) => {
    try {
        res.status(200).json({ msg: 'Logged out successfully' });
    } catch (error) {
      console.error('Error logging out:', error);
      res.status(500).json({ msg: 'Server Error' });
    }
  });
  



module.exports = authRouter;