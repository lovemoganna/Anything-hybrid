const path = require('path');
const glob = require('glob');
const merge = require('webpack-merge');
const webpack = require('webpack');

const HtmlWebpackPlugin = require('html-webpack-plugin');
const CaseSensitivePathsPlugin = require('case-sensitive-paths-webpack-plugin');
const FriendlyErrorsPlugin = require('friendly-errors-webpack-plugin');
const Jarvis = require('webpack-jarvis');

const parts = require('./webpack.parts');

const SpeedMeasurePlugin = require('speed-measure-webpack-plugin');
const smp = new SpeedMeasurePlugin();


// define work directory
const PATHS = {
  app: path.join(__dirname, 'src'),
  build: path.join(__dirname, 'dist'),
};

// common config , there no config CSS
const commonConfig = merge([{
  devtool: 'eval-source-map',
  plugins: [
    new HtmlWebpackPlugin({
      title: 'Hot Module Replacement',
    }),
    new Jarvis({
      port: 3000, // optional: set a port
    }),
    new webpack.HotModuleReplacementPlugin(),
    new CaseSensitivePathsPlugin(),
    new FriendlyErrorsPlugin({
      compilationSuccessInfo: {
        messages: [`You application is running! `],
        notes: ['Some additionnal notes to be displayed unpon successful compilation'],
      },
      onErrors: function(severity, errors) {
        // You can listen to errors transformed and prioritized by the plugin
        // severity can be 'error' or 'warning'
      },
      // should the console be cleared between each compilation?
      // default is true
      clearConsole: true,

      // add formatters and transformers (see below)
      additionalFormatters: [],
      additionalTransformers: [],
    }),
    new webpack.LoaderOptionsPlugin({
      // solve module build file: eslint
      // refer_address https://github.com/webpack/webpack/issues/6556
      options: {},
    }),
  ],
  entry: {
    // this is a entry point,maybe have css sort problem.you should strict fllow css import rule in sequence
    // if you don't use MCEP ,you could install css-entry-webpack-plugina. The plugin can extract css bundle from entry without MECP.
    // style: glob.sync("./src/**/*.css"),
    main: __dirname + '/src/index.js',
  },
  output: {
    path: PATHS.build,
    chunkFilename: '[name].[hash:4].js',
    filename: '[name].[hash:4].js',
    sourceMapFilename: '[file].map',
  },
},
parts.bundleAnalysis(),
parts.setFreeVariable('HELLO', 'hello from config'),
parts.webpackDashboard(),
parts.checkPackage(),
]);

// dev config
const developmentConfig = merge([
  parts.devServer({
    // Customize host/port here if needed
    host: process.env.HOST,
    port: process.env.PORT,
  }),
  parts.loadCSS(),
  parts.loadImages(),
  parts.generateSourceMaps({type: 'inline-source-map'}),
]);
// prod config
const productionConfig = merge([
  parts.extractCSS({
    use: ['css-loader', parts.autoprefix()],
  }),
  parts.purifyCSS({
    paths: glob.sync(`${PATHS.app}/**/*.js`, {
      nodir: true,
    }),
  }),
  parts.loadImages({
    options: {
      limit: 15000,
      name: '[name].[hash:4].[ext]',
    },
  }),
  parts.generateSourceMaps({type: 'source-map'}),
  // {
  //   optimization: {
  //     splitChunks: {
  //       chunks: 'initial',
  //     },
  //   },
  // },
  {
    optimization: {
      splitChunks: {
        cacheGroups: {
          commons: {
            test: /[\\/]node_modules[\\/]/,
            name: 'vendor',
            chunks: 'initial',
          },
        },
      },
      runtimeChunk: {
        name: 'manifest',
      },
    },
  },
  {
    recordsPath: path.join(__dirname, 'records.json'),
  },
  {
    // 定义性能预算,自定义bundle大小.
    performance: {
      hints: 'warning', // "error" or false are valid too
      maxEntrypointSize: 50000, // in bytes, default 250k
      maxAssetSize: 450000, // in bytes
    },
  },
  parts.clean(PATHS.build),
  parts.attachRevision(),
  parts.minifyJavaScript(),
  parts.minifyCSS({
    options: {
      discardComments: {
        removeAll: true,
      },
      // Run cssnano in safe mode to avoid
      // potentially unsafe transformations.
      safe: true,
    },
  }),
  parts.showStatus('stats.json'),
  // parts.webpackMonitor(),
]);
module.exports = smp.wrap((mode) =>{
  if (mode === 'production') {
    return merge(commonConfig, productionConfig, {
      mode,
    });
  }
  return merge(commonConfig, developmentConfig, {
    mode,
  });
});
