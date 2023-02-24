const { a } = require('@cycle/react-dom');
const path = require('path');

module.exports = {
    entry: './src/index.js',
    mode: 'production',
    output: {
        path: path.resolve(__dirname, 'build'),
        publicPath: '/',
        clean: true,
    },
    devServer: {
        historyApiFallback: true,
    },
    module: {
        rules: [
            {
                test: /\.(js|jsx)$/,
                exclude: /node_modules/,
                resolve: {
                    extensions: ['.js', '.jsx'],
                },
                use: {
                    loader: 'babel-loader',
                },
            },
        ],
    },
};

