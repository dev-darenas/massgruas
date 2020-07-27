# Bootstrap extra: Add nav, nav_js and combo_nav_js helpers and templates for Bootstrap pagination
# See https://ddnexus.github.io/pagy/extras/bootstrap
require 'pagy/extras/bootstrap'

# Instance variables
# See https://ddnexus.github.io/pagy/api/pagy#instance-variables
Pagy::VARS[:items] = 10                                   # default

# I18n

# Pagy internal I18n: ~18x faster using ~10x less memory than the i18n gem
# See https://ddnexus.github.io/pagy/api/frontend#i18n
# Notice: No need to configure anything in this section if your app uses only "en"
# or if you use the i18n extra below
#
# Examples:
# load the "de" built-in locale:
 Pagy::I18n.load(locale: 'es')
