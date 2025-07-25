defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    # Please implement the palette_bit_size/1 function
    round(Float.ceil(:math.log2(color_count)))
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    palette_sz = palette_bit_size(color_count)
    case picture do
      <<>> ->
        nil
      <<value::size(palette_sz), _::bitstring>> ->
        value
    end
  end

  def drop_first_pixel(picture, color_count) do
    palette_sz = palette_bit_size(color_count)
    case picture do
      <<>> ->
        <<>>
      <<_::size(palette_sz), rest::bitstring>> ->
        rest
    end
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
