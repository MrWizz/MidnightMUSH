$:.unshift File.dirname(__FILE__)

load "controllers/admin/admin.rb"
load "controllers/admin/shutdown.rb"
load "controllers/admin/logs.rb"

load "controllers/config/config.rb"
load "controllers/config/config_edit.rb"
load "controllers/config/config_update.rb"
load "controllers/config/config_date.rb"
load "controllers/config/config_secrets.rb"
load "controllers/config/config_skin.rb"
load "controllers/config/config_names.rb"
load "controllers/config/config_game_info.rb"
load "controllers/config/config_web.rb"
load "controllers/config/config_webfiles.rb"

load "controllers/wiki/edit_create_page.rb"
load "controllers/wiki/wiki.rb"

load "controllers/session.rb"
load "controllers/web.rb"
load "controllers/formatters.rb"
load "controllers/files.rb"

load "helpers/wiki_markdown/tag_match_helper.rb"
load "helpers/wiki_markdown/char_gallery.rb"
load "helpers/wiki_markdown/div_block.rb"
load "helpers/wiki_markdown/image.rb"
load "helpers/wiki_markdown/include.rb"
load "helpers/wiki_markdown/music_player.rb"
load "helpers/wiki_markdown/page_list.rb"
load "helpers/wiki_markdown/scene_list.rb"
load "helpers/wiki_markdown/span_block.rb"
load "helpers/wiki_markdown/wikidot_compatibility.rb"
load "helpers/wiki_markdown/markdown_finalizer.rb"
load "helpers/wiki_markdown/wiki_markdown_extensions.rb"
load "helpers/wiki_markdown/wiki_markdown_formatter.rb"
load "helpers/recaptcha_helper.rb"
load "helpers/filename_sanitizer.rb"
