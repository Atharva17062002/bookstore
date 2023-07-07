const mongoose = require('mongoose')

const wishlistSchema = mongoose.Schema(
    {
        userId: {
            type: String,
            required: true
        },
        bookId: {
            type: String,
            required: true,
        },
        name: {
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
        },
        price: {
            type: String,
            required: true,
        }
    },
)

const wish = mongoose.model('Wishlist', wishlistSchema);

module.exports = wish;