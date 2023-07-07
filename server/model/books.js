const mongoose = require('mongoose')

const booksSchema = mongoose.Schema(
    {
        name: {
            type: String,
            required: [true, "Please enter a book name"]
        },
        price: {
            type: String,
            required: true,
        },
        image: {
            type: String,
            required: true,
        },
        author: {
            type: String,
            required: true,
        }
    },
    {
        timestamps: true
    }
)


const Book = mongoose.model('Book', booksSchema);

module.exports = Book;