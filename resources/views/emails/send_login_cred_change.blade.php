Estimado {{ $user->name }},<br><br>

Tus credenciales de inicio de sesi&oacute;n han cambiado:<br><br>

Nombre de usuario: {{ $user->email }}<br>
Contrase&ntilde;a: {{ $password }}<br><br>

Puedes iniciar sesi&oacute;n desde <a href="{{ url('/login') }}">{{ str_replace("http://", "", url('/login')) }}</a>.<br><br>

Atentamente,
