
#
# _vp_ 20180201
# ishapi / tags / _widget
#

json.id      tag.id.to_s
json.name    tag.name
json.tagname tag.tagname

json.partial! 'ishapi/newsitems/index', :newsitems => tag.newsitems.limit(1)
