module.exports = {
  any: {
    unknown: 'não é permitido',
    invalid: 'contains an invalid value',
    empty: 'é obrigatório',
    required: 'é obrigatório',
    allowOnly: 'deve ser um dos valores {{valids}}',
    default: 'threw an error when running default method'
  },
  alternatives: {
    base: 'not matching any of the allowed alternatives',
    child: null
  },
  array: {
    base: 'must be an array',
    includes: 'at position {{pos}} does not match any of the allowed types',
    includesSingle: 'single value of "{{!label}}" does not match any of the allowed types',
    includesOne: 'at position {{pos}} fails because {{reason}}',
    includesOneSingle: 'single value of "{{!label}}" fails because {{reason}}',
    includesRequiredUnknowns: 'does not contain {{unknownMisses}} required value(s)',
    includesRequiredKnowns: 'does not contain {{knownMisses}}',
    includesRequiredBoth: 'does not contain {{knownMisses}} and {{unknownMisses}} other required value(s)',
    excludes: 'at position {{pos}} contains an excluded value',
    excludesSingle: 'single value of "{{!label}}" contains an excluded value',
    min: 'must contain at least {{limit}} items',
    max: 'must contain less than or equal to {{limit}} items',
    length: 'must contain {{limit}} items',
    ordered: 'at position {{pos}} fails because {{reason}}',
    orderedLength: 'at position {{pos}} fails because array must contain at most {{limit}} items',
    ref: 'references "{{ref}}" which is not a positive integer',
    sparse: 'must not be a sparse array',
    unique: 'position {{pos}} contains a duplicate value'
  },
  boolean: {
    base: 'deve ser um booleano'
  },
  binary: {
    base: 'must be a buffer or a string',
    min: 'must be at least {{limit}} bytes',
    max: 'must be less than or equal to {{limit}} bytes',
    length: 'must be {{limit}} bytes'
  },
  date: {
    base: 'inválido',
    format: 'must be a string with one of the following formats {{format}}',
    strict: 'must be a valid date',
    min: 'deve ser maior ou igual que "{{limit}}"',
    max: 'deve ser menor ou igual que "{{limit}}"',
    less: 'must be less than "{{limit}}"',
    greater: 'must be greater than "{{limit}}"',
    isoDate: 'must be a valid ISO 8601 date',
    timestamp: {
      javascript: 'must be a valid timestamp or number of milliseconds',
      unix: 'must be a valid timestamp or number of seconds'
    },
    ref: 'references "{{ref}}" which is not a date'
  },
  function: {
    base: 'must be a Function',
    arity: 'must have an arity of {{n}}',
    minArity: 'must have an arity greater or equal to {{n}}',
    maxArity: 'must have an arity lesser or equal to {{n}}',
    ref: 'must be a Joi reference',
    class: 'must be a class'
  },
  lazy: {
    base: '!!schema error: lazy schema must be set',
    schema: '!!schema error: lazy schema function must return a schema'
  },
  object: {
    base: 'must be an object',
    child: '!!child "{{!child}}" fails because {{reason}}',
    min: 'must have at least {{limit}} children',
    max: 'must have less than or equal to {{limit}} children',
    length: 'must have {{limit}} children',
    allowUnknown: '!!"{{!child}}" não é permitido',
    with: '!!"{{mainWithLabel}}" missing required peer "{{peerWithLabel}}"',
    without: '!!"{{mainWithLabel}}" conflict with forbidden peer "{{peerWithLabel}}"',
    missing: 'must contain at least one of {{peersWithLabels}}',
    xor: 'contains a conflict between exclusive peers {{peersWithLabels}}',
    or: 'must contain at least one of {{peersWithLabels}}',
    and: 'contains {{presentWithLabels}} without its required peers {{missingWithLabels}}',
    nand: '!!"{{mainWithLabel}}" must not exist simultaneously with {{peersWithLabels}}',
    assert: '!!"{{ref}}" validation failed because "{{ref}}" failed to {{message}}',
    rename: {
      multiple: 'cannot rename child "{{from}}" because multiple renames are disabled and another key was already renamed to "{{to}}"',
      override: 'cannot rename child "{{from}}" because override is disabled and target "{{to}}" exists',
      regex: {
        multiple: 'cannot rename children {{from}} because multiple renames are disabled and another key was already renamed to "{{to}}"',
        override: 'cannot rename children {{from}} because override is disabled and target "{{to}}" exists'
      }
    },
    type: 'must be an instance of "{{type}}"',
    schema: 'must be a Joi instance'
  },
  number: {
    base: 'deve ser um número',
    min: 'deve ser maior ou igual que {{limit}}',
    max: 'deve ser menor ou igual que {{limit}}',
    less: 'must be less than {{limit}}',
    greater: 'must be greater than {{limit}}',
    float: 'must be a float or double',
    integer: 'deve ser um inteiro',
    negative: 'must be a negative number',
    positive: 'must be a positive number',
    precision: 'must have no more than {{limit}} decimal places',
    ref: 'references "{{ref}}" which is not a number',
    multiple: 'must be a multiple of {{multiple}}',
    port: 'must be a valid port'
  },
  string: {
    base: 'deve ser um texto',
    min: 'deve ter pelo menos {{limit}} caracteres',
    max: 'não pode ter mais que {{limit}} caracteres',
    length: 'deve ter {{limit}} caracteres',
    alphanum: 'must only contain alpha-numeric characters',
    token: 'must only contain alpha-numeric and underscore characters',
    regex: {
      base: 'com formato inválido',
      name: 'with value "{{!value}}" fails to match the {{name}} pattern',
      invert: {
        base: 'with value "{{!value}}" matches the inverted pattern: {{pattern}}',
        name: 'with value "{{!value}}" matches the inverted {{name}} pattern'
      }
    },
    email: 'inválido',
    uri: 'must be a valid uri',
    uriRelativeOnly: 'must be a valid relative uri',
    uriCustomScheme: 'must be a valid uri with a scheme matching the {{scheme}} pattern',
    isoDate: 'must be a valid ISO 8601 date',
    guid: 'must be a valid GUID',
    hex: 'must only contain hexadecimal characters',
    hexAlign: 'hex decoded representation must be byte aligned',
    base64: 'must be a valid base64 string',
    hostname: 'must be a valid hostname',
    normalize: 'must be unicode normalized in the {{form}} form',
    lowercase: 'must only contain lowercase characters',
    uppercase: 'must only contain uppercase characters',
    trim: 'must not have leading or trailing whitespace',
    creditCard: 'must be a credit card',
    ref: 'references "{{ref}}" which is not a number',
    ip: 'must be a valid ip address with a {{cidr}} CIDR',
    ipVersion: 'must be a valid ip address of one of the following versions {{version}} with a {{cidr}} CIDR'
  },
  password: {
    valid: 'deve ter letras e números.'
  },
  cpf: {
    valid: 'inválido.'
  },
  cnpj: {
    valid: 'inválido.'
  }
}
