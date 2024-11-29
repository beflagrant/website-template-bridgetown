const build = require("./config/esbuild.defaults.js")

// You can customize this as you wish, perhaps to add new esbuild plugins.
//
// ```
// const path = require("path")
// const esbuildCopy = require('esbuild-plugin-copy').default
// const esbuildOptions = {
//   plugins: [
//     esbuildCopy({
//       assets: {
//         from: [path.resolve(__dirname, 'node_modules/somepackage/files/*')],
//         to: [path.resolve(__dirname, 'output/_bridgetown/somepackage/files')],
//       },
//       verbose: false
//     }),
//   ]
// }
// ```
//
// You can also support custom base_path deployments via changing `publicPath`.
//
// ```
// const esbuildOptions = {
//   publicPath: "/my_subfolder/_bridgetown/static",
//   ...
// }
// ```

if (process.env.BASE_PATH === undefined) {
  console.log('process.env.BASE_PATH was undefined, setting "/"')
  process.env.BASE_PATH = "/" }
else {
    console.log('process.env.BASE_PATH == ', process.env.BASE_PATH)
}

/**
 * @typedef { import("esbuild").BuildOptions } BuildOptions
 * @type {BuildOptions}
 */
const esbuildOptions = {
  define: {
    "process.env.BASE_PATH": `"${process.env.BASE_PATH}"`,
  },
  plugins: [
    // add new plugins here...
  ],
  publicPath: path.join(process.env.BASE_PATH, "_bridgetown", "static"),
  globOptions: {
    excludeFilter: /\.(dsd|lit)\.css$/
  }
}

build(esbuildOptions)
