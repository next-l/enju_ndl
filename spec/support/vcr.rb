VCR.configure do |c|
  c.cassette_library_dir     = 'spec/cassette_library'
  c.hook_into                :fakeweb
end
