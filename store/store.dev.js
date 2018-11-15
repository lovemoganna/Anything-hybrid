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
export {developmentConfig};
