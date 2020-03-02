import resolve from "@rollup/plugin-node-resolve";
import commonjs from "@rollup/plugin-commonjs";
import typescript from "rollup-plugin-typescript2";
import multi from "@rollup/plugin-multi-entry";
import wasm from "@rollup/plugin-wasm";

export default {
  input: [`typescript/src/index.ts`],
  output: {
    sourcemap: true,
    format: "iife",
    name: "ed25519-ts",
    file: `typescript/dist/bundle.js`
  },
  plugins: [
    multi(),
    resolve({
      browser: true,
      extensions: [".js", ".ts", ".wasm"]
    }),
    commonjs({
      include: [
        `typescript/**/*.js`,
        `typescript/**/*.ts`,
        `typescript/**/*.wasm`,
        "node_modules/**"
      ]
    }),
    typescript(),
    wasm()

    // If we're building for prod (npm run build
    // instead of npm run dev), minify
    // terser()
  ]
};
