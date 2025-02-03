import type { Denops } from "jsr:@denops/std@~7.4.0";
import {
    type ContextBuilder,
    type ExtOptions,
    type Plugin,
} from "jsr:@shougo/dpp-vim@~4.1.0/types";
import {
    BaseConfig,
    type ConfigReturn,
} from "jsr:@shougo/dpp-vim@~4.1.0/config";
import type {
    Ext as TomlExt,
    Params as TomlParams,
} from "jsr:@shougo/dpp-ext-toml@~1.3.0";
import type {
    Ext as LazyExt,
    Params as LazyParams,
} from "jsr:@shougo/dpp-ext-lazy@~1.5.0";
import { Protocol } from "jsr:@shougo/dpp-vim@~4.1.0/protocol";
import { mergeFtplugins } from "jsr:@shougo/dpp-vim@~4.1.0/utils";
import { globToRegExp } from "jsr:@std/path";
import { walk } from "jsr:@std/fs";

async function glob(root: string, glob: string): Promise<string[]> {
    const tomlWalked = walk(root, { match: [globToRegExp(glob)] });
    return (await Array.fromAsync(tomlWalked)).map((v) => v.path);
}

export class Config extends BaseConfig {
    override async config(args: {
        denops: Denops;
        contextBuilder: ContextBuilder;
        basePath: string;
    }): Promise<ConfigReturn> {
        const base = Deno.env.get("BASE_DIR");
        if (base === undefined || base === "") {
            return { plugins: [] };
        }

        const [tomlExt, tomlOptions, tomlParams]: [
            TomlExt | undefined,
            ExtOptions,
            TomlParams,
        ] = await args.denops.dispatcher.getExt(
            "toml",
        ) as [TomlExt | undefined, ExtOptions, TomlParams];
        if (!tomlExt) {
            return { plugins: [] };
        }

        const [lazyExt, lazyOptions, lazyParams]: [
            LazyExt | undefined,
            ExtOptions,
            LazyParams,
        ] = await args.denops.dispatcher.getExt(
            "lazy",
        ) as [LazyExt | undefined, ExtOptions, LazyParams];
        if (!lazyExt) {
            return { plugins: [] };
        }

        args.contextBuilder.setGlobal({
            protocols: ["git"],
        });

        const [context, options] = await args.contextBuilder.get(args.denops);
        const protocols = await args.denops.dispatcher.getProtocols() as Record<
            string,
            Protocol
        >;

        const tomlFiles = await glob(base, "**/*.toml");
        const tomls = await Promise.all(
            tomlFiles.map((toml) =>
                tomlExt.actions.load.callback({
                    denops: args.denops,
                    context,
                    options,
                    protocols,
                    extOptions: tomlOptions,
                    extParams: tomlParams,
                    actionParams: { path: toml, options: { lazy: true } },
                })
            ),
        );

        const records: Record<string, Plugin> = {};
        const ftplugins: Record<string, string> = {};
        const hooksFiles: string[] = [];

        for (const toml of tomls) {
            for (const plugin of toml.plugins ?? []) {
                records[plugin.name] = plugin;
            }
            if (toml.ftplugins) {
                mergeFtplugins(ftplugins, toml.ftplugins);
            }
            if (toml.hooks_file) {
                hooksFiles.push(toml.hooks_file);
            }
        }

        const state = await lazyExt.actions.makeState.callback({
            denops: args.denops,
            context,
            options,
            protocols,
            extOptions: lazyOptions,
            extParams: lazyParams,
            actionParams: {
                plugins: Object.values(records),
            },
        });

        return {
            checkFiles: await glob(base, "**/*.*"),
            ftplugins,
            hooksFiles,
            multipleHooks: [],
            plugins: state.plugins,
            stateLines: state.stateLines,
        };
    }
}
