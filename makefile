THIS_DIR    := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

help: ## Show this help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

prod-serve: ## Serve a prod version of the site
	export NODE_ENV=production && hugo -e production serve --minify -d public_html

prod: ## Build a prod version of the site
	export NODE_ENV=production && hugo -e production --minify -d public_html

serve: ## Serve the dev version of the site
	hugo serve
