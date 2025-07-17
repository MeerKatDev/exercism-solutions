class Triangle<out T : Number>(val a: T, val b: T, val c: T) {
  init {
    val da = a.toDouble()
    val db = b.toDouble()
    val dc = c.toDouble()

    require((da > 0) && (db > 0) && (dc > 0))
    require((da + db > dc) && (db + dc > da) && (da + dc > db))
  }

  private val sideSizeCount = listOf(a, b, c).distinct().count()

  val isEquilateral: Boolean = (sideSizeCount == 1)
  val isIsosceles: Boolean = (sideSizeCount <= 2)
  val isScalene: Boolean = (sideSizeCount == 3)
}
