import {
	BaseConfig,
	ConfigReturn,
	ContextBuilder,
	Dpp,
	Plugin,
} from "https://deno.land/x/dpp_vim@v0.0.9/types.ts";
import {
	Denops,
	fn,
} from "https://deno.land/x/dpp_vim@v0.0.9/deps.ts";

type Toml = {
	hooks_file?: string;
	ftplugins?: Record<string, string>;
	plugins?: Plugin[];
}
type LazyMakeStateResult = {
	plugins: Plugin[];
	stateLines: string[];
}

export class Config extends BaseConfig {
	override async config(args: {
		denops: Denops;
		contextBuilder: ContextBuilder;
		basePath: string;
		dpp: Dpp;
	}): Promise<ConfigReturn> {
		args.contextBuilder.setGlobal({
			extParams: {
				installer: {
					checkDiff: true,
					logFilePath: "~/.config/nvim/dpp/dpp-ext-installer-log.txt",
				},
				/*git: {
					enablePartialClone: true,
				},*/
			},
			protocols: ["git"] ,      
		});

		const [context, options] = await args.contextBuilder.get(args.denops);
		const tomls: Toml[] = [];
		for (
			const tomlFile of [
				await fn.expand(args.denops, "~/.config/nvim/dpp.toml"),
			]
		) {
			const toml = await args.dpp.extAction(
					args.denops,
					context,
					options,
					"toml",
					"load",
					{
						path: tomlFile,
						options: {
							lazy: false,
						},
					},
				) as Toml | undefined;
			if (toml) {
				tomls.push(toml);
			}
		}
		for (
			const tomlFile of [
				await fn.expand(args.denops, "~/.config/nvim/dpp_lazy.toml"),
			]
		) {
			const toml = await args.dpp.extAction(
					args.denops,
					context,
					options,
					"toml",
					"load",
					{
						path: tomlFile,
						options: {
							lazy: true,
						},
					},
				) as Toml | undefined;
			if (toml) {
				tomls.push(toml)
			}
		}

		const recordPlugins: Record<string, Plugin> = {};
		const ftplugins:     Record<string, string> = {};
		const hooksFiles:    string[]               = [];

		tomls.forEach((toml) => {
			if (toml.plugins) {
				for (const plugin of toml.plugins) {
					recordPlugins[plugin.name] = plugin;
				}
			}
			if (toml.ftplugins) {
				for (const filetype of Object.keys(toml.ftplugins)) {
					if (ftplugins[filetype]) {
						ftplugins[filetype] += `\n${toml.ftplugins[filetype]}`;
					} else {
						ftplugins[filetype] = toml.ftplugins[filetype];
					}
				}
			}
			if (toml.hooks_file) {
				hooksFiles.push(toml.hooks_file);
			}
		});

		const lazyResult = await args.dpp.extAction(
			args.denops,
			context,
			options,
			"lazy",
			"makeState",
			{
				plugins: Object.values(recordPlugins),
			},
		) as LazyMakeStateResult | undefined;
		
		return {
			checkFiles: await fn.globpath(
				args.denops,
				"~/.config/nvim/dpp",
				"*",
				1,
				1,
			) as unknown as string[],
			ftplugins,
			hooksFiles,
			plugins: lazyResult?.plugins ?? [],
			stateLines: lazyResult?.stateLines ?? [],
		}
	}
}
