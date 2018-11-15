const webpack = require('webpack');
const cssnano = require('cssnano');
// use separating css plugin
const PurifyCSSPlugin = require('purifycss-webpack');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');

const GitRevisionPlugin = require('git-revision-webpack-plugin');
const TerserPlugin = require('terser-webpack-plugin');

const StatsPlugin = require('stats-webpack-plugin');
const WebpackMonitor = require('webpack-monitor');
const DashboardPlugin = require('webpack-dashboard/plugin');
const DuplicatePackageCheckerPlugin = require('duplicate-package-checker-webpack-plugin');
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;

exports.devServer = ({
  host,
  port,
} = {}) => ({
  devServer: {
    stats: 'errors-only',
    host, // Defaults to `localhost`
    port, // Defaults to 8080
    open: true,
    // 控制台输出简单的错误提示
    overlay: true,
    // 禁止ifriendly-errors-webpack-plugin错误提示
    // quiet: true,
    hot: true,
  },
});

// 检测bundle打包
exports.bundleAnalysis= ()=>({
  plugins: [
    new BundleAnalyzerPlugin(),
  ],
});
// 检测重复的包安装
exports.checkPackage = ()=>({
  plugins: [new DuplicatePackageCheckerPlugin()],
});
// webpack dashboard
exports.webpackDashboard = ()=>({
  plugins: [
    new DashboardPlugin(),
  ],
});

// webpack生产环境性能监控
exports.webpackMonitor =()=>({
  plugins: [
    new WebpackMonitor({
      capture: true, // -> default 'true'
      target: '../monitor/myStatsStore.json', // default -> '../monitor/stats.json'
      launch: true, // -> default 'false'
      port: 3030, // default -> 8081
      excludeSourceMaps: true, // default 'true'
    }),
  ],
});
// 管理统计数据
exports.showStatus=({options})=>({
  plugins: [
    new StatsPlugin(options, {
      chunkModules: true,
      exclude: [/node_modules[\\\/]react/],
    }),
  ],
});

// 缩小css文件
exports.minifyCSS = ({options}) => ({
  plugins: [
    new OptimizeCSSAssetsPlugin({
      cssProcessor: cssnano,
      cssProcessorOptions: options,
      canPrint: false,
    }),
  ],
});

// 设置process.env.NODE_ENV 环境变量
exports.setFreeVariable = (key, value) => {
  const env = {};
  env[key] = JSON.stringify(value);

  return {
    plugins: [new webpack.DefinePlugin(env)],
  };
};
// 缩小JS文件
exports.minifyJavaScript = () => ({
  optimization: {
    minimizer: [new TerserPlugin({sourceMap: true})],
  },
});

// 将与当前构建版本相关的信息附加到构建文件本身可用于调试。
exports.attachRevision = () => ({
  plugins: [
    new webpack.BannerPlugin({
      banner: new GitRevisionPlugin().version(),
    }),
  ],
});
// configure clean plugin
exports.clean = (path) => ({
  plugins: [new CleanWebpackPlugin([path])],
});
// configure sourceMap
exports.generateSourceMaps = ({type}) => ({
  devtool: type,
});

// setting up autoprefix
exports.autoprefix = () => ({
  loader: 'postcss-loader',
  options: {
    plugins: () => [require('autoprefixer')()],
  },
});
// setting up purify css
exports.purifyCSS = ({
  paths,
}) => ({
  plugins: [new PurifyCSSPlugin({
    paths,
  })],
});
// loading image
exports.loadImages = ({include, exclude, options} = {}) => ({
  module: {
    rules: [
      {
        test: /\.(png|jpg)$/,
        include,
        exclude,
        use: {
          loader: 'url-loader',
          options,
        },
      },
      {
        test: /\.svg$/,
        use: 'file-loader',
      },
    ],
  },
});
// parser css assert
// add sass ,need install node-sass
exports.loadCSS = ({
  include,
  exclude,
} = {}) => ({
  module: {
    rules: [{
      test: /\.css$/,
      include,
      exclude,
      use: ['style-loader',
        {
          // parse sass file
          loader: 'css-loader',
          options: {
            importLoaders: 2,
          },
        },
        'sass-loader',
        {
          loader: 'postcss-loader',
          options: {
            plugins: () => ([
              require('precss'),
              require('postcss-cssnext'),
            ]),
          },
        },
      ],
    }],
  },
});


// setting up MCEP

exports.extractCSS = ({
  include,
  exclude,
  use = [],
}) => {
  // Output extracted CSS to a file
  const plugin = new MiniCssExtractPlugin({
    filename: '[name].css',
  });

  return {
    module: {
      rules: [{
        test: /\.css$/,
        include,
        exclude,
        use: [
          MiniCssExtractPlugin.loader,
        ].concat(use),
      }],
    },
    plugins: [plugin],
  };
};
