Estimado {{ $user->name }},<br><br>

Has sido registrado en {{ url('/') }}.<br><br>

Tus credenciales de inicio de sesi&oacute;n son descritas a continuaci&oacute;n:<br><br>

Nombre de usuario: {{ $user->email }}<br>
Contrase&ntilde;a: {{ $password }}<br><br>

Puedes iniciar sesi&oacute;n desde <a href="{{ url('/login') }}">{{ str_replace("http://", "", url('/login')) }}</a>.<br><br>

Atentamente,
