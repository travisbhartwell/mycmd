use std::env;
use std::os::unix::process::CommandExt;
use std::path::{Path, PathBuf};
use std::process::Command;

struct MyCmdConfig {
    base_directory: PathBuf,
    debug_mode: bool,
}

static DEFAULT_COMMAND_BASE_DIR_NAME: &str = "mycmd";
static DEBUG_ENV_VAR_NAME: &str = "MYCMD_DEBUG";
static COMPLETION_FLAG: &str = "--mycmd-complete";

impl MyCmdConfig {
    pub fn new() -> Self {
        let debug_mode: bool = env::var(DEBUG_ENV_VAR_NAME).is_ok();
        let base_directory: PathBuf =
            Path::new(&env::var("HOME").unwrap()).join(DEFAULT_COMMAND_BASE_DIR_NAME);

        Self {
            base_directory,
            debug_mode,
        }
    }
}

struct CommandWithArguments {
    command_path: PathBuf,
    args: Vec<String>,
}

fn find_completions(config: MyCmdConfig, mycmd_args: Vec<String>) {
    let mut potential_path: PathBuf = config.base_directory;
    let mut args_iter = mycmd_args.iter();
}

fn find_command(
    config: MyCmdConfig,
    mycmd_args: Vec<String>,
) -> Result<CommandWithArguments, &'static str> {
    let mut potential_path: PathBuf = config.base_directory;
    let mut args_iter = mycmd_args.iter();

    loop {
        if let Some(component) = args_iter.next() {
            println!(
                "Have path {:?}, adding component: {:?}.",
                potential_path, component
            );

            potential_path = potential_path.join(component);

            if !potential_path.exists() {
                return Err("Path does not exist");
            }

            if potential_path.is_file() {
                return Ok(CommandWithArguments {
                    command_path: potential_path,
                    args: args_iter.into_iter().cloned().collect(),
                });
            }
        } else {
            return Err("Path does not exist");
        }
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let my_cmd_config = MyCmdConfig::new();
    println!("Base directory: {:?}", my_cmd_config.base_directory);

    let mut args: env::Args = env::args();

    if args.len() == 1 {
        eprintln!("Missing required arguments\n");
        return Ok(());
    }

    args.next();
    let args_vec: Vec<_> = args.collect();

    // For simplicty, only look accept the completion flag at the last position
    if args_vec.last().unwrap() == COMPLETION_FLAG {
        println!("Received completion argument!");
        let mut args_vec = args_vec;
        args_vec.pop();
        find_completions(my_cmd_config, args_vec);
    } else {
        let cmd_with_args: CommandWithArguments = find_command(my_cmd_config, args_vec)?;

        println!("Found command at: {:?}", cmd_with_args.command_path);

        let mut command = Command::new(cmd_with_args.command_path);

        if !cmd_with_args.args.is_empty() {
            println!("Found command arguments with: {:?}", cmd_with_args.args);
            command.args(cmd_with_args.args);
        }

        command.exec();
    }

    Ok(())
}
