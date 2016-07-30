defmodule AccessitTest do
  use ExUnit.Case
  import Accessit

  doctest Accessit

  def dummy_data do
    %{fields: [
        %{name: "rank", rank: 0},
        %{name: "location", location: ""}],
      type: "how-common-is-surname"}
  end

  def rank_100_data do
    %{fields: [
        %{name: "rank", rank: 100},
        %{name: "location", location: ""}],
      type: "how-common-is-surname"}
  end

  def wales_data do
    %{fields: [
        %{name: "rank", rank: 0},
        %{name: "location", location: "Wales"}],
      type: "how-common-is-surname"}
  end

  def deep_data do
    %{fields: [
        %{name: "rank", rank: 0},
        %{name: "locations", location: ["Wales", "Scotland", "Dorset"]}],
      type: "how-common-is-surname"}
  end

  def english_data do
    %{fields: [
        %{name: "rank", rank: 0},
        %{name: "locations", location: ["Wales", "Scotland", "England"]}],
      type: "how-common-is-surname"}
  end

  def english_data do
    %{fields: [
        %{name: "rank", rank: 0},
        %{name: "locations", location: ["Wales", "Scotland", "England"]}],
      type: "how-common-is-surname"}
  end

  def upper_cased_names do
    %{fields: [
        %{name: "RANK", rank: 0},
        %{name: "LOCATION", location: ""}],
      type: "how-common-is-surname"}
  end

  test "takes a string representation of array location and correctly transforms the associated data" do
    assert put_in(dummy_data, access_at( "{:fields}->[0]->{:rank}"), 100) == rank_100_data
  end

  test "takes a string representation of array location looking in second position and correctly transforms the associated data" do
    assert put_in(dummy_data, access_at( "{:fields}->[1]->{:location}"), "Wales") == wales_data
  end

  test "takes a string representation of array location in a deep data_structure and correctly transforms the associated data" do
    assert put_in(deep_data, access_at( "{:fields}->[1]->{:location}->[2]"), "England") == english_data
  end

  test "takes an * as a list element and converts it to Access.all" do
    assert update_in(dummy_data, access_at( "{:fields}->[*]->{:name}"), &String.upcase/1) == upper_cased_names
  end

end
