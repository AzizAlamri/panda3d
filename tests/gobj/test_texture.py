from panda3d.core import Texture, PNMImage
from array import array


def image_from_stored_pixel(component_type, format, data):
    """ Creates a 1-pixel texture with the given settings and pixel data,
    then returns a PNMImage as result of calling texture.store(). """

    tex = Texture("")
    tex.setup_1d_texture(1, component_type, format)
    tex.set_ram_image(data)

    img = PNMImage()
    assert tex.store(img)
    return img


def test_texture_store_unsigned_byte():
    data = array('B', (2, 1, 0, 0xff))
    img = image_from_stored_pixel(Texture.T_unsigned_byte, Texture.F_rgba, data)

    assert img.maxval == 0xff
    pix = img.get_pixel(0, 0)
    assert tuple(pix) == (0, 1, 2, 0xff)


def test_texture_store_unsigned_short():
    data = array('H', (2, 1, 0, 0xffff))
    img = image_from_stored_pixel(Texture.T_unsigned_short, Texture.F_rgba, data)

    assert img.maxval == 0xffff
    pix = img.get_pixel(0, 0)
    assert tuple(pix) == (0, 1, 2, 0xffff)


def test_texture_store_unsigned_int():
    data = array('I', (0x30000, 2, 0, 0xffffffff))
    img = image_from_stored_pixel(Texture.T_unsigned_int, Texture.F_rgba, data)

    assert img.maxval == 0xffff
    pix = img.get_pixel(0, 0)
    assert tuple(pix) == (0, 0, 3, 0xffff)


def test_texture_store_float():
    data = array('f', (0.5, 0.0, -2.0, 10000.0))
    img = image_from_stored_pixel(Texture.T_float, Texture.F_rgba, data)

    assert img.maxval == 0xffff
    col = img.get_xel_a(0, 0)
    assert col.almost_equal((0.0, 0.0, 0.5, 1.0), 1 / 255.0)


def test_texture_store_half():
    # Python's array class doesn't support half floats, so we hardcode the
    # binary representation of these numbers:
    data = array('H', (
        # -[exp][mantissa]
        0b0011110000000000, # 1.0
        0b1100000000000000, # -2.0
        0b0111101111111111, # 65504.0
        0b0011010101010101, # 0.333251953125
    ))
    img = image_from_stored_pixel(Texture.T_half_float, Texture.F_rgba, data)

    assert img.maxval == 0xffff
    col = img.get_xel_a(0, 0)
    assert col.almost_equal((1.0, 0.0, 1.0, 0.333251953125), 1 / 255.0)


def test_texture_store_srgb():
    # 188 = roughly middle gray
    data = array('B', [188, 188, 188])
    img = image_from_stored_pixel(Texture.T_unsigned_byte, Texture.F_srgb, data)

    # We allow some imprecision.
    assert img.maxval == 0xff
    col = img.get_xel(0, 0)
    assert col.almost_equal((0.5, 0.5, 0.5), 1 / 255.0)


def test_texture_store_srgb_alpha():
    # 188 = middle gray
    data = array('B', [188, 188, 188, 188])
    img = image_from_stored_pixel(Texture.T_unsigned_byte, Texture.F_srgb_alpha, data)

    # We allow some imprecision.
    assert img.maxval == 0xff
    col = img.get_xel_a(0, 0)
    assert col.almost_equal((0.5, 0.5, 0.5, 188 / 255.0), 1 / 255.0)
