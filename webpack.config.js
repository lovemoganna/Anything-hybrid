/**
 * @fileOverview
 * @name webpack.config.js
 * @author luoyupiaoshang
 * @license MIT
 */
const HtmlWebpackPlugin = require("html-webpack-plugin");
///////////////////////////////////////////////////////////////////////////////
//                     add html-webpack-plugin in webpack                    //
/////////////////////////////////////////////////////////////////////////////// 

module.exports = {
    plugins: [
        new HtmlWebpackPlugin({
            title: "Webpack demo",
        }),
    ],
};