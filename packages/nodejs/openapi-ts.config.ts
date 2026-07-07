import { defineConfig } from "@hey-api/openapi-ts";
import camelcase from "camelcase";

const METHOD_TO_OPERATION: Record<string, string> = {
  GET: "get",
  POST: "create",
  PUT: "update",
  PATCH: "patch",
  DELETE: "delete",
};

export default defineConfig({
  input: "https://api.natsuneko.com/openapi.json",
  output: "./src/generated",
  plugins: [
    "@hey-api/typescript",
    {
      name: "@hey-api/sdk",
      auth: true,
      operations: {
        containerName: "CatalystClient",
        strategy: "single",
        nesting(operation) {
          const { path, method } = operation;
          const segments = path.split("/").filter(Boolean);
          return [
            segments[0],
            ...segments.map((w) => camelcase(w)),
            METHOD_TO_OPERATION[method.toUpperCase()],
          ];
        },
      },
    },
  ],
});
