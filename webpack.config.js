const glob = require("glob");
const merge = require("webpack-merge");
const HtmlWebpackPlugin = require("html-webpack-plugin");

const parts = require("./webpack.parts");


// common config , there no config css
const commonConfig = merge([{
        plugins: [
            new HtmlWebpackPlugin({
                title: "Webpack demo",
            }),
        ],
        entry: {
            //this is a entry point,maybe have css sort problem.you should strict fllow css import rule in sequence
            // if you don't use MCEP ,you could install css-entry-webpack-plugina. The plugin can extract css bundle from entry without MECP.
            style: glob.sync("./src/**/*.css"),
        },
    },
    //  parts.loadCSS(),
]);

//const productionConfig = merge([]);

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
        use: "css-loader",
    }),
]);

module.exports = mode => {
    if (mode === "production") {
        return merge(commonConfig, productionConfig, {
            mode
        });
    }

    return merge(commonConfig, developmentConfig, {
        mode
    });
};
