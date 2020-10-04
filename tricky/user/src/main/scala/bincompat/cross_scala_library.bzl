load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library", "scala_test")

def _cross_names(name, cross_build):
  for cross in cross_build:
    suffix = "_".join([key + "_" + value for key, value in cross.items()])
    deps_map = {k: k + v for k, v in cross.items()}
    yield deps_map, name + "_" + suffix

def cross_scala_library(name, cross_build, deps,**kwargs):
  for cross, cross_name in _cross_names(name, cross_build):
    scala_library(
      name = cross_name,
      deps = [dep.format_map(cross) in deps],
      **kwargs
    )

