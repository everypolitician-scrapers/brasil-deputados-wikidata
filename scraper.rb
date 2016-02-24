#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'
require 'nokogiri'
require 'open-uri/cached'
OpenURI::Cache.cache_path = '.cache'


def noko_for(url)
  Nokogiri::HTML(open(URI.escape(URI.unescape(url))).read) 
end

def wikinames_from(url)
  noko = noko_for(url)
  noko.css('#Mesa_Diretora_2').xpath('following::*').remove
  
  names = noko.xpath('//table//th[contains(.,"Nome")]').map do |th|
    wantcol = th.xpath("ancestor::tr").last.css('th').find_index { |th| th.text.to_s.include? 'Nome' }
    th.xpath("ancestor::table").last.xpath(".//td[#{wantcol + 1}]//a[not(@class='new')]/@title").map { |t| t.text }
  end
  raise "No names found in #{url}" if names.count.zero?
  return names
end

names = wikinames_from('https://pt.wikipedia.org/wiki/Lista_de_deputados_federais_do_Brasil_da_55.ª_legislatura')
EveryPolitician::Wikidata.scrape_wikidata(names: { pt: names.flatten.uniq })
