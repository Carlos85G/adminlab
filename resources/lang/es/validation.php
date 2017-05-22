<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Validation Language Lines
    |--------------------------------------------------------------------------
    |
    | The following language lines contain the default error messages used by
    | the validator class. Some of these rules have multiple versions such
    | as the size rules. Feel free to tweak each of these messages here.
    |
    */

    'accepted'             => ':attribute debe ser aceptado.',
    'active_url'           => ':attribute no es una dirección URL válida.',
    'after'                => ':attribute debe ser una fecha después de :date.',
    'alpha'                => ':attribute sólo puede contener letras.',
    'alpha_dash'           => ':attribute sólo puede contener letras, números y guiones.',
    'alpha_num'            => ':attribute sólo puede contener letras y números.',
    'array'                => ':attribute debe ser un arreglo.',
    'before'               => ':attribute debe ser una fecha anterior a :date.',
    'between'              => [
        'numeric' => ':attribute debe estar entre :min y :max.',
        'file'    => ':attribute debe abarcar entre :min y :max kilobytes.',
        'string'  => ':attribute debe tener entre :min y :max caracteres.',
        'array'   => ':attribute debe tener entre :min y :max ítems.',
    ],
    'boolean'              => ':attribute debe ser cierto o falso.',
    'confirmed'            => 'La confirmación de :attribute no es igual.',
    'date'                 => ':attribute no es una fecha válida.',
    'date_format'          => ':attribute no tiene el formato :format.',
    'different'            => ':attribute y :other deben ser diferentes.',
    'digits'               => ':attribute debe de tener :digits dígitos.',
    'digits_between'       => ':attribute debe tener entre :min y :max dígitos.',
    'distinct'             => ':attribute tiene un valor duplicado.',
    'email'                => ':attribute debe ser una dirección de correo electrónico válida.',
    'exists'               => 'La selección de :attribute no es válida.',
    'filled'               => ':attribute es requerido.',
    'image'                => ':attribute debe ser una imagen.',
    'in'                   => 'La selección de :attribute no es válida.',
    'in_array'             => ':attribute no existe en :other.',
    'integer'              => ':attribute debe ser un entero.',
    'ip'                   => ':attribute debe ser una dirección IP válida.',
    'json'                 => ':attribute debe ser una cadena JSON válida.',
    'max'                  => [
        'numeric' => ':attribute no puede ser mayor a :max.',
        'file'    => ':attribute no puede ser mayor a :max kilobytes.',
        'string'  => ':attribute no puede tener más de :max caracteres.',
        'array'   => ':attribute no puede tener más de :max ítems.',
    ],
    'mimes'                => ':attribute debe ser un archivo de tipo: :values.',
    'min'                  => [
        'numeric' => ':attribute debe ser al menos :min.',
        'file'    => ':attribute debe ser de al menos :min kilobytes.',
        'string'  => ':attribute debe tener al menos :min caracteres.',
        'array'   => ':attribute debe tener al menos :min ítems.',
    ],
    'not_in'               => 'La selección de :attribute no es válida.',
    'numeric'              => ':attribute debe ser un número.',
    'present'              => ':attribute debe estar presente.',
    'regex'                => 'EL formato de :attribute no es válido.',
    'required'             => ':attribute es requerido.',
    'required_if'          => ':attribute es requerido cuando :other es :value.',
    'required_unless'      => ':attribute es requerido a menos que :other esté en :values.',
    'required_with'        => ':attribute es requerido cuando :values está presente.',
    'required_with_all'    => ':attribute es requerido cuando :values está presente.',
    'required_without'     => ':attribute es requerido cuando :values no está presente.',
    'required_without_all' => ':attribute es requerido cuando ningún valor de :values está presente.',
    'same'                 => ':attribute y :other deben ser iguales.',
    'size'                 => [
        'numeric' => ':attribute debe ser :size.',
        'file'    => ':attribute debe ser de :size kilobytes.',
        'string'  => ':attribute debe ser de :size caracteres.',
        'array'   => ':attribute debe contener :size ítems.',
    ],
    'string'               => ':attribute debe ser una cadena.',
    'timezone'             => ':attribute debe ser una zona horaria válida.',
    'unique'               => ':attribute ya fue utilizado.',
    'url'                  => 'El formato de :attribute no es válido.',

    /*
    |--------------------------------------------------------------------------
    | Custom Validation Language Lines
    |--------------------------------------------------------------------------
    |
    | Here you may specify custom validation messages for attributes using the
    | convention "attribute.rule" to name the lines. This makes it quick to
    | specify a specific custom language line for a given attribute rule.
    |
    */

    'custom' => [
        'attribute-name' => [
            'rule-name' => 'custom-message',
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Custom Validation Attributes
    |--------------------------------------------------------------------------
    |
    | The following language lines are used to swap attribute place-holders
    | with something more reader friendly such as E-Mail Address instead
    | of "email". This simply helps us make messages a little cleaner.
    |
    */

    'attributes' => [],

];
