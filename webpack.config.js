const path = require("path");
const glob = require("glob");
const merge = require("webpack-merge");

const HtmlWebpackPlugin = require("html-webpack-plugin");
const CaseSensitivePathsPlugin = require('case-sensitive-paths-webpack-plugin');
const FriendlyErrorsPlugin = require('friendly-errors-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const webpack = require('webpack');

const parts = require("./webpack.parts");

// define work directory 
const PATHS = {
    app: path.join(__dirname, "src"),
};

// common config , there no config css
const commonConfig = merge([{
    devtool: 'eval-source-map',
    plugins: [
        new CleanWebpackPlugin(['public']),
        new HtmlWebpackPlugin({
            title: "Hot Module Replacement",
        }),
        new webpack.HotModuleReplacementPlugin(),
        new CaseSensitivePathsPlugin(),
        new FriendlyErrorsPlugin({
            compilationSuccessInfo: {
                messages: [`You application is running! `],

                notes: ['Some additionnal notes to be displayed unpon successful compilation']
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
            additionalTransformers: []
        })
    ],
    entry: {
        //this is a entry point,maybe have css sort problem.you should strict fllow css import rule in sequence
        // if you don't use MCEP ,you could install css-entry-webpack-plugina. The plugin can extract css bundle from entry without MECP.
        // style: glob.sync("./src/**/*.css"),  
        main: __dirname + "/src/index.js",
    },
    output: {
        path: __dirname + "/public",
        filename: "bundle.js"
    }
}, ]);


// dev config 
const developmentConfig = merge([
    parts.devServer({
        // Customize host/port here if needed
        host: "0.0.0.0",
        port: process.env.PORT,
    }),
    parts.loadCSS(),
]);


// pro config 
const productionConfig = merge([
    parts.extractCSS({
        use: ["css-loader", parts.autoprefix()],
    }),
    parts.purifyCSS({
        paths: glob.sync(`${PATHS.app}/**/*.js`, {
            nodir: true
        }),
    }),
]);

module.exports = mode => {
    if (mode === "production") {
        return merge(commonConfig, productionConfig, {
            mode,
            module: {
                rules: [{
                        // **Conditions** to match files using RegExp, function.
                        test: /\.js$/,

                        // **Restrictions**
                        // Restrict matching to a directory. This
                        // also accepts an array of paths or a function.
                        // The same applies to `exclude`.
                        include: path.join(__dirname, "c"),
                        exclude(path) {
                            // You can perform more complicated checks  as well.
                            return path.match(/node_modules/);
                        },

                        // **Actions** to apply loaders to the matched files.
                        use: "babel-loader",
                    },
                    {
                        test: /\.css$/,
                        use: "style-loader",
                    },
                    {
                        test: /\.css$/,
                        use: "css-loader",
                    },
                    {
                        // Conditions
                        test: /\.js$/,
                        enforce: "pre", // "post" too

                        // Actions
                        use: "eslint-loader",
                    },
                ],
            },
        });
    }

    return merge(commonConfig, developmentConfig, {
        mode
    });
};
