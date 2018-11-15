const HtmlWebpackPlugin = require('html-webpack-plugin');
const merge = require('webpack-merge');
const path =require('path');
const parts = require('./webpack.parts');

const PATHS = {
  app: path.join(__dirname, 'src'),
  build: path.join(__dirname, 'dist'),
};
exports.page = ({
  path = '',
  template = require.resolve(
      'html-webpack-plugin/default_index.ejs'
  ),
  title,
} = {}) => ({
  plugins: [
    new HtmlWebpackPlugin({
      filename: `${path && path + '/'}index.html`,
      template,
      title,
    }),
  ],
});

const commonConfig = merge([
  {
    output: {
      // Needed for code splitting to work in nested paths
      publicPath: '/dist',
    },
  },
]);
module.exports = (mode) => {
  const pages = [
    parts.page({
      title: 'Webpack demo',
      entry: {
        app: PATHS.app,
      },
    }),
    parts.page({
      title: 'Another demo',
      path: 'another',
      entry: {
        another: path.join(PATHS.app, 'another.js'),
      },
    }),
  ];
  const config =
        mode === 'production' ? productionConfig : developmentConfig;
  return merge([commonConfig, config, {mode}].concat(pages));
};
