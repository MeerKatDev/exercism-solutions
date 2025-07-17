object Flattener {
  fun flatten(source: List<Any?>): List<Any?> {
      return source.fold(listOf()) { x, hd ->
        when (hd) {
            is List<*> -> x + flatten(hd)
            null -> x
            else -> x + listOf(hd)
        }
      }
  }
}
