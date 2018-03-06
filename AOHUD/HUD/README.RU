ВНИМАНИЕ!
Данный HUD не содержит анимаций!
Но вы можете загрузить свои!

1. Что это
Это простой пример, как можно с помощью новых LSL функций AnimationOverride сделать
простой AO HUD для замены стандартных анимаций.

2. Как работает
Перед запуском HUD Вам необходимо произвести настройку.
Вы можете использовать встроенные анимации. 
Список: http://wiki.secondlife.com/wiki/Internal_Animations
эти анимации доступны всегда, даже если их нет в вашем инвентаре.

Так Вы можете загрузить в объект любые другие анимации и использовать их

Перед началом работы вам необходимо открыть HUD на редактирование.
Изменить нотекарту config.txt.
Синтаксис очень простой. 
Название состояние аватара;Имя анимации

Возможные состояния аватара:
Crouching
CrouchWalking
Falling Down
Flying
FlyingSlow
Hovering
Hovering Down
Hovering Up
Jumping
Landing *
PreJumping *
Running
Sitting
Sitting on Ground
Standing
Standing Up *
Striding
Soft Landing *
Taking Off
Turning Left
Turning Right
Walking
  
*Некоторые состояния являются переходными и имеют неопределенное 
поведение, если они настроены на непрерывную циклическую анимацию. 
Этими состояниями являются «PreJumping», «Landing», «Soft Landing» и «Standing Up».