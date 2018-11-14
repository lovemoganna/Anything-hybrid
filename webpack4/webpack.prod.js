const webpack = require('webpack');
const merge = require('webpack-merge');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');
const common = require('./webpack.common.js');

module.exports = merge(common, {
    devtool: 'source-map',
    plugins: [
        new UglifyJSPlugin(
            {sourceMap: true}
        ),
        new webpack.DefinePlugin({
            // 设置在生产环境中构建.
            'process.env.NODE_ENV': JSON.stringify('production')
        })
    ]
});
