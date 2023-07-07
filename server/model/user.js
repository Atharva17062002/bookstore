const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  email: {
    type: String,
    // required: true,
    trim: true,
    unique: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
          return value.match(re);
      },
      message: "Please enter a valid email address"
    },
  },
  password:{
    type: String,
    required: true,
    validate: {
      validator: (value) => {
      
          return value.length>6;
      },
      message: "Please enter a password length > 6"
    },
  },
  address: {
    type: String,
  
  },
  type:{
    type: String,
    default: "user"
  }
});

const User = mongoose.model("User", userSchema);

module.exports = User;
