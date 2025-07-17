import kotlin.math.pow

object HandshakeCalculator {
  fun calculateHandshake(number: Int): List<Signal> =
    Signal
      .values()
      .filter { (number and powTwo(it.ordinal)) > 0.0 }
      .let { if ((number and powTwo(4)) > 0) it.reversed() else it }

  fun powTwo(exp: Int): Int = 2.0.pow(exp).toInt()
}
