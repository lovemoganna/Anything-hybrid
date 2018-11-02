// use separating css plugin 
const PurifyCSSPlugin = require("purifycss-webpack");
exports.devServer = ({
    host,
    port
} = {}) => ({
    devServer: {
        stats: "errors-only",
        host, // Defaults to `localhost`
        port, // Defaults to 8080
        open: true,
        overlay: true,
    },
});

// setting up purify css  
exports.purifyCSS = ({ paths }) => ({
    plugins: [new PurifyCSSPlugin({ paths })],
});
// parser css assert 
// add sass ,need install node-sass 
exports.loadCSS = ({
    include,
    exclude
} = {}) => ({
    module: {
        rules: [{
            test: /\.css$/,
            include,
            exclude,
            use: ["style-loader",
                {
                    // parse sass file
                    loader: "css-loader",
                    options: {
                        importLoaders: 2,
                    },
                },
                "sass-loader",
                {
                    loader: "postcss-loader",
                    options: {
                        plugins: () => ([
                            require("precss"),
                            require("postcss-cssnext"),
                        ]),
                    },
                },
            ],
        }, ],
    },
});


// setting up MCEP

exports.extractCSS = ({
    include,
    exclude,
    use = []
}) => {
    // Output extracted CSS to a file
    const plugin = new MiniCssExtractPlugin({
        filename: "[name].css",
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
            }, ],
        },
        plugins: [plugin],
    };
};
