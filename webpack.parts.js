exports.page = (
    {
      path = '',
      template = require.resolve(
          'html-webpack-plugin/default_index.ejs'
      ),
      title,
      entry,
      chunks,
    } = {}
) => ({
  entry,
  plugins: [
    new HtmlWebpackPlugin({
      chunks,
    }),
  ],
});
exports.loadJavaScript = ({include, exclude} = {}) => ({
  module: {
    rules: [
      {
        test: /\.js$/,
        include,
        exclude,
        use: 'babel-loader',
      },
    ],
  },
});
