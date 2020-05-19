import haxe.Json;
import sys.io.File;

class Build {
    public static var packageLockJson:Dynamic = {
  "name": "Artemis",
  "version": "0.0.1",
  "lockfileVersion": 1,
  "requires": true,
  "dependencies": {
    "pako": {
      "version": "1.0.10",
      "resolved": "https://registry.npmjs.org/pako/-/pako-1.0.10.tgz",
      "integrity": "sha512-0DTvPVU3ed8+HNXOu5Bs+o//Mbdj9VNQMUOe9oKCwh8l0GNwpTDMKCWbRjgtD291AWnkAgkqA/LOnQS8AmS1tw=="
    },
    "ws": {
      "version": "7.2.1",
      "resolved": "https://registry.npmjs.org/ws/-/ws-7.2.1.tgz",
      "integrity": "sha512-sucePNSafamSKoOqoNfBd8V0StlkzJKL2ZAhGQinCfNQ+oacw+Pk7lcdAElecBF2VkLNZRiIb5Oi1Q5lVUVt2A=="
    }
    }
  };
	public static var packageJson:Dynamic = {
		"name": "Artemis",
		"description": "A discord bot",
		"version": "0.0.1",
		"engines": {
			"node": "12.x"
		},
		"dependencies": {
			"pako": "1.0.11",
      "ws": "7.2.3"
		},
		"devDependencies": {
			"nodemon": "2.0.2"
		},
		"scripts": {
			"start": "nodemon node/bot.js --ignore '*.json'"
		}
	}

    public static function main(){
        File.write("node/Procfile").writeString("worker: node bot.js");
        File.write("node/package.json").writeString(Json.stringify(packageJson));
        File.write("node/package-lock.json").writeString(Json.stringify(packageLockJson));
        Sys.exit(0);
    }
}