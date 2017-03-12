/* @flow */

var path = require('path');

module.exports = {
  entry: "./front/src/main.jsx",
  devtool: "inline-source-map",
  output: {
    path: "public",
    filename: "bundle.js"
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        include: [
          path.resolve(__dirname, "front/src"),
        ],
        exclude: /node_modules/,
        use: 'babel-loader'
      }
    ]
  },
  resolve: {
    modules: [
      path.join(__dirname, "front/src"),
      "node_modules"
    ],
    extensions: ['.js', '.jsx']
  }
};
