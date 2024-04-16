# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.digest = true
Rails.application.config.assets.precompile += [
  "*.svg", "*.eot", "*.woff",
  "*.ttf", "*.woff2", "*.png",
  "themes/*.css"
]

NonStupidDigestAssets.whitelist += [/.(?i:)(?:svg|eot|woff|woff2|ttf|otf)$/]
