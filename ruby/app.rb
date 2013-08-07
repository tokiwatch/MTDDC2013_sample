# -*- encoding: utf-8 -*-

require 'rubygems'
require 'sinatra'
require 'sequel'
require 'json'

DB = Sequel.connect(
    :adapter  => 'mysql',
    :host     => 'localhost',
    :database => 'hoge',
    :user     => 'hoge',
    :password => 'hoge',
    :encoding => "utf8"
)


Sequel.inflections do |inflect|
    inflect.irregular 'mt_entry', 'mt_entry'
end

class Mt_entry < Sequel::Model
        plugin :force_encoding, 'utf-8'
end

get '/:blog_id' do
    my_entries = Mt_entry
        .select(:entry_id,:entry_title)
        .filter(:entry_blog_id => params[:blog_id])

    my_result = Array.new()
    my_entries.each do |x|
        h = Hash.new()
        h = {
                :entry_id    => x[:entry_id],
                :entry_title => x[:entry_title]
        }
        my_result.push(h)
    end

    content_type :json
    my_result.to_json
end


