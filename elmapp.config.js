module.exports = {
    configureWebpack: (config, env) => {
      // Manipulate the config object and return it.
      console.log(config.module.rules[2]);
      config.module.rules[2].exclude = [/[/\\\\]node_modules[/\\\\]/];
      return config;
    }
  }