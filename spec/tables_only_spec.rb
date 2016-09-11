# encoding: utf-8
require 'spec_helper'

describe "tables_only" do
  let(:connection) { ActiveRecord::Base.connection }

  def drop_dummy_view(v)
    connection.execute "DROP VIEW IF EXISTS #{v}"
  end

  def create_dummy_view(v, t)
    drop_dummy_view v
    connection.execute "CREATE VIEW #{v} AS SELECT * FROM #{t}"
  end

  around(:each) do |example|
    begin
      connection.tables_only.each do |table|
        connection.drop_table table, force: :cascade
      end
      connection.create_table :t1
      connection.create_table :t2
      create_dummy_view :v1, :t1
      create_dummy_view :v2, :t2
      example.run
    ensure
      drop_dummy_view :v1
      drop_dummy_view :v2
      connection.drop_table :t1, if_exists: true
      connection.drop_table :t2, if_exists: true
    end
  end

  it "does not cause deprecation" do
    expect(ActiveSupport::Deprecation).not_to receive(:warn)
    connection.tables_only
  end

  it "lists all tables" do
    t = connection.tables_only

    # Tables may include ar_internal_metadata on AR5
    if t.include? "ar_internal_metadata"
      expect(connection.tables_only).to match_array %w[t1 t2 ar_internal_metadata]
    else
      expect(connection.tables_only).to match_array %w[t1 t2]
    end
  end

  it "user_tables_only doesn't list internal tables" do
    # user_tables_only shouldn't return ar_internal_metadata
    expect(connection.user_tables_only).to match_array %w[t1 t2]
  end


end
