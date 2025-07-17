object Flattener {
  fun flatten(source: List<Any?>): List<Any> {
      return source.fold(listOf()) { x, hd ->
        x + (when (hd) {
            is List<*> -> flatten(hd)
            null -> listOf()
            else -> listOf(hd)
        })
      }
  }
}
