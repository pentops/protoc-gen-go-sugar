Go Proto Sugar
==============

Extends the default protoc-gen-go with some sugar shortcuts.


Short Enum
----------

Proto enum values must be uniquely named in each namespace, however the Go gode adds an extra prefix,
so that:

```
enum foo {
	FOO_UNSPECIFIED = 0;
	FOO_A = 1;
}
```

befomes `package.Foo_FOO_A`

With this enum extension:

- The const `package.Foo_A` is created
- The map `package.Foo_name_short` works like the inbuilt `package.Foo_name`
- The map `package.Foo_value_short` works like the inbuilt `package.Foo_value`
- The map `package.Foo_value_either` is a merger of the short and long values, useful for input data
- Method `ShortString()` returns the `_name_short` string.

When the parameter `sql_driver` is true, an additional set of methods make the Enum work with SQL drivers directly:


- `Value()` method returns the ShortString() (Short string as SQL enums are already namespaced)
- ``Scan(interface{})` method decodes as flexibly as it can, using either string representation.

This only works when the first value has the `_UNSPECIFIED` suffix, which indicates the Buf naming standard has been used. (a future version could be more flexible)


Expose OneOf
------------

The inbuilt oneof implementation uses an isFoo and unexposed fields to ensure
that OneOf values are of the correct type. The developers continue to argue about
fixing that implementation but believe that it's a bad setup, as oneOf is 'just validation'.
This would be fine, but it's not how they built it, so look...

Anyway, this extension just copies the isFoo to IsFoo so that you can use that type elsewhere.
