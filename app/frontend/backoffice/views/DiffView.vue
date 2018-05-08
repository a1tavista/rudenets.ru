<template>
  <div class="diff">
    <ul>
      <li class="unchanged"><span># Технический долг</span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>## Frontend/SCSS</span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>- Некорректное разбиение компонентов на страницах на с</span></li>
      <li class="unchanged"><span>- </span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>ga</span></li>
      <li class="unchanged"><span>ag</span></li>
      <li class="unchanged"><span>ag</span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>ag</span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>ag</span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>ga</span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>ag</span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>ga</span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>ag</span></li>
      <li class="unchanged"><span></span></li>
      <li class="del"><del>ga</del></li>
      <li class="ins"><ins>ga<strong>ggggggg</strong></ins></li>
      <li class="unchanged"><span>- </span></li>
      <li class="unchanged"><span>- </span></li>
      <li class="unchanged"><span>- ущности БЭМ: привязка блоков к конкретной бизнес-сущности (например, supply-request-list для таблиц, которые можно переиспользовать множество раз для разных целей)</span></li>
      <li class="unchanged"><span>- Некорректное использование БЭМ в компонентах (например, селекторы, зависящие от порядка размещения элементов, селекторы по тегам, обертки)</span></li>
      <li class="unchanged"><span>- Неиспользование БЭМ в компонентах панели администратора</span></li>
      <li class="unchanged"><span>- Copy-paste</span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>## Frontend/JS</span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>- [x] Неэффективная архитектура приложения: разбиение на компоненты без указания контекста использования данного компонента</span></li>
      <li class="unchanged"><span>- [x] Неэффективная организация файловой структуры в папке components</span></li>
      <li class="unchanged"><span>- [ ] Передача данных в динамические элементы посредством props</span></li>
      <li class="unchanged"><span>- [ ] Коммуникация целого дерева компонентов без использования store</span></li>
      <li class="unchanged"><span>- [ ] Нет единого источника истины для валидаций</span></li>
      <li class="unchanged"><span>- [ ] Возможно, проще сделать SPA, чем пытаться скрестить сложные динамические элементы со статическими</span></li>
      <li class="unchanged"><span>- [x] Не разделены бандлы для личных кабинетов клиента, поставщика, инженера, что увеличивает бесполезную нагрузку</span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>## Backend</span></li>
      <li class="unchanged"><span></span></li>
      <li class="unchanged"><span>- Fat controllers</span></li>
      <li class="unchanged"><span>- Отсутствие тестов на процессы, описанные в контроллерах</span></li>
      <li class="unchanged"><span>- API-методы смешиваются с обычными методами</span></li>
      <li class="unchanged"><span>- Определение тела ответа внутри контроллера для некоторых API-методов</span></li>
      <li class="unchanged"><span>- Строки внутри контроллеров без локалей</span></li>
      <li class="unchanged"><span>- Переизбыток методов, выполняющих одно и то же действие, внутри контроллеров панели администратора</span></li>
      <li class="unchanged"><span>- Отсутствие foreign keys для некоторых таблиц many-to-many</span></li>
      <li class="unchanged"><span>- Слишком сложная модель данных, возможно упрощение имен и сокращение количества сущностей:</span></li>
      <li class="unchanged"><span>	- SupplyRequest переименовать в Tender (для упрощения словаря разработчика, куда короче говорить и писать Tender, чем SupplyRequest)</span></li>
      <li class="unchanged"><span>	- Order переименовать в Deal (для исключения коннотации с Offer)</span></li>
      <li class="unchanged"><span>	- Все сущности, связанные напрямую с тендерами, снабдить префиксом Tender (e.g. Tender::Lot, Tender::File, Tender::Bid, Tender::Invoice, Tender::Offer, Tender::Deal)</span></li>
      <li class="unchanged"><span>	- Все сущности, связанные напрямую с клиентами, снабдить префиксом Consumer (e.g. Consumer::Counterparty, Consumer::DeliveryAddress)</span></li>
      <li class="unchanged"><span>  - SupplyFile переименовать в TenderFile</span></li>
      <li class="unchanged"><span>	- SupplyFileError упразднить, ошибки хранить вместе с TenderFile в виде JSON-объекта</span></li>
      <li class="unchanged"><span>	- SupplyRequestSection упразднить, данные объединить с Tender::Lot</span></li>
      <li class="unchanged"><span>- Упрощение модели SupplyRequest:</span></li>
      <li class="unchanged"><span>  - Вынести методы, связанные с деревом состояний, в concern для дальнейшего подключения в модель</span></li>
      <li class="unchanged"><span>  - Вынести методы, связанные с парсингом файлов, в соответствующие сервисы</span></li>
    </ul>
  </div>
</template>

<script>
  export default {}
</script>

<style>
  .diff {
    overflow: auto;
  }

  .diff ul {
    background: #FFFFFF;
    overflow: auto;
    font-size: 13px;
    list-style: none;
    margin: 0;
    padding: 0;
    display: table;
    width: 100%;
  }

  .diff del, .diff ins {
    display: block;
    text-decoration: none;
  }

  .diff li {
    padding: 0;
    display: table-row;
    margin: 0;
    height: 1em;
  }

  .diff li.ins {
    background: #DDFFDD;
    color: #008800
  }

  .diff li.del {
    background: #FFEEEE;
    color: #BB0000
  }

  .diff li:hover {
    background: #FFFFCC
  }

  /* try 'whitespace:pre;' if you don't want lines to wrap */
  .diff del, .diff ins, .diff span {
    white-space: pre-wrap;
    font-family: courier;
  }

  .diff del strong {
    font-weight: normal;
    background: #FFCCCC;
  }

  .diff ins strong {
    font-weight: normal;
    background: #99FF99;
  }

  .diff li.diff-comment {
    display: none;
  }

  .diff li.diff-block-info {
    background: none repeat scroll 0 0 gray;
  }
</style>
