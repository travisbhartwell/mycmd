use std::env;
use std::os::unix::process::CommandExt;
use std::path::{Path, PathBuf};
use std::process::Command;

struct MyCmdConfig {
    base_directory: PathBuf,
}

static DEFAULT_COMMAND_BASE_DIR_NAME: &str = "mycmd";
static COMPLETION_FLAG: &str = "--mycmd-complete";

impl MyCmdConfig {
    pub fn new() -> Self {
        Self {
            base_directory: Path::new(&env::var("HOME").unwrap())
                .join(DEFAULT_COMMAND_BASE_DIR_NAME),
        }
    }
}

struct CommandWithArguments {
    command_path: PathBuf,
    args: Vec<String>,
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

    let cmd_with_args: CommandWithArguments = find_command(my_cmd_config, args.collect())?;

    println!("Found command at: {:?}", cmd_with_args.command_path);

    let mut command = Command::new(cmd_with_args.command_path);

    if !cmd_with_args.args.is_empty() {
        command.args(cmd_with_args.args);
    }

    command.exec();

    Ok(())
}
