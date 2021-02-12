{include file="common/header-1.tpl" nocache}
<div class="row dashboard">
  <div class="col-md-3"> {include file="left-nav-dashboard.tpl" nocache} </div>
  <div class="col-md-9">
    <h4 class="ds_brd">{$pharse.add} {$type} {$pharse.address}</h4>
    <form action="{$config['url']}/dashboard/Myaddress" method="post" id="shipping" name="shipping" accept-charset="utf-8" data-parsley-validate>
      <input type="hidden" name="type" value="{$type}" id="addresstype" />
      <div class="row">
        <div class="form-group">
          <label for="inputEmail" class="col-md-4" >{$pharse.name:}</label>
          <div class="col-md-8">
            <input type="text" id="name" name="name" placeholder="Enter your name" value="{$shipping.name}" class="form-control" title="Enter your name" maxlength="20" required>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="form-group">
          <label for="inputEmail" class="col-md-4" >{$pharse.address_line_1:}</label>
          <div class="col-md-8">
            <input type="text" id="address_line1" name="address1" placeholder="Enter your address line1" class="form-control" value="{$shipping.address1}" title="Address Line 1" maxlength="50" required>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="form-group">
          <label for="inputEmail" class="col-md-4" >{$pharse.address_line_2:}</label>
          <div class="col-md-8">
            <input type="text" id="address_line2" name="address2" placeholder="Enter your address line2" class="form-control"  value="{$shipping.address2}" title="Address Line 2" maxlength="50">
          </div>
        </div>
      </div>
      <div class="row">
        <div class="form-group">
          <label for="inputEmail" class="col-md-4" >{$pharse.country:}</label>
          <div class="col-md-8">
            <select name="country" id="country" class="form-control" required>
              <option value="" selected="selected">{$pharse.select_country}</option>
              <option value="" selected="selected">{$pharse.select_country}</option>
              <option value="AF">{$pharse.afghanistan}</option>
              <option value="AL">{$pharse.albania}</option>
              <option value="DZ">{$pharse.algeria}</option>
              <option value="AS">{$pharse.american_samoa}</option>
              <option value="AD">{$pharse.andorra}</option>
              <option value="AO">{$pharse.angola}</option>
              <option value="AI">{$pharse.anguilla}</option>
              <option value="AQ">{$pharse.antarctica}</option>
              <option value="AG">{$pharse.antigua_and_barbuda}</option>
              <option value="AR">{$pharse.argentina}</option>
              <option value="AM">{$pharse.armenia}</option>
              <option value="AW">{$pharse.aruba}</option>
              <option value="AU">{$pharse.australia}</option>
              <option value="AT">{$pharse.austria}</option>
              <option value="AZ">{$pharse.azerbaijan}</option>
              <option value="BS">{$pharse.bahamas}</option>
              <option value="BH">{$pharse.bahrain}</option>
              <option value="BD">{$pharse.bangladesh}</option>
              <option value="BB">{$pharse.barbados}</option>
              <option value="BY">{$pharse.belarus}</option>
              <option value="BE">{$pharse.belgium}</option>
              <option value="BZ">{$pharse.belize}</option>
              <option value="BJ">{$pharse.benin}</option>
              <option value="BM">{$pharse.bermuda}</option>
              <option value="BT">{$pharse.bhutan}</option>
              <option value="BO">{$pharse.bolivia}</option>
              <option value="BA">{$pharse.bosnia_and_herzegowina}</option>
              <option value="BW">{$pharse.botswana}</option>
              <option value="BV">{$pharse.bouvet_island}</option>
              <option value="BR">{$pharse.brazil}</option>
              <option value="IO">{$pharse.british_indian_ocean_territory}</option>
              <option value="BN">{$pharse.brunei_darussalam}</option>
              <option value="BG">{$pharse.bulgaria}</option>
              <option value="BF">{$pharse.burkina_faso}</option>
              <option value="BI">{$pharse.burundi}</option>
              <option value="KH">{$pharse.cambodia}</option>
              <option value="CM">{$pharse.cameroon}</option>
              <option value="CA">{$pharse.canada}</option>
              <option value="CV">{$pharse.cape_verde}</option>
              <option value="KY">{$pharse.cayman_islands}</option>
              <option value="CF">{$pharse.central_african_republic}</option>
              <option value="TD">{$pharse.chad}</option>
              <option value="CL">{$pharse.chile}</option>
              <option value="CN">{$pharse.china}</option>
              <option value="CX">{$pharse.christmas_island}</option>
              <option value="CC">{$pharse.cocos_(keeling)_islands}</option>
              <option value="CO">{$pharse.colombia}</option>
              <option value="KM">{$pharse.comoros}</option>
              <option value="CG">{$pharse.congo}</option>
              <option value="CK">{$pharse.cook_islands}</option>
              <option value="CR">{$pharse.costa_rica}</option>
              <option value="CI">{$pharse.cote_d'ivoire}</option>
              <option value="HR">{$pharse.croatia}</option>
              <option value="CU">{$pharse.cuba}</option>
              <option value="CY">{$pharse.cyprus}</option>
              <option value="CZ">{$pharse.czech_republic}</option>
              <option value="DK">{$pharse.denmark}</option>
              <option value="DJ">{$pharse.djibouti}</option>
              <option value="DM">{$pharse.dominica}</option>
              <option value="DO">{$pharse.dominican_republic}</option>
              <option value="TP">{$pharse.east_timor}</option>
              <option value="EC">{$pharse.ecuador}</option>
              <option value="EG">{$pharse.egypt}</option>
              <option value="SV">{$pharse.el_salvador}</option>
              <option value="GQ">{$pharse.equatorial_guinea}</option>
              <option value="ER">{$pharse.eritrea}</option>
              <option value="EE">{$pharse.estonia}</option>
              <option value="ET">{$pharse.ethiopia}</option>
              <option value="FK">{$pharse.falkland_islands_(malvinas)}</option>
              <option value="FO">{$pharse.faroe_islands}</option>
              <option value="FJ">{$pharse.fiji}</option>
              <option value="FI">{$pharse.finland}</option>
              <option value="FR">{$pharse.france}</option>
              <option value="FX">{$pharse.france,_metropolitan}</option>
              <option value="GF">{$pharse.french_guiana}</option>
              <option value="PF">{$pharse.french_polynesia}</option>
              <option value="TF">{$pharse.french_southern_territories}</option>
              <option value="GA">{$pharse.gabon}</option>
              <option value="GM">{$pharse.gambia}</option>
              <option value="GE">{$pharse.georgia}</option>
              <option value="DE">{$pharse.germany}</option>
              <option value="GH">{$pharse.ghana}</option>
              <option value="GI">{$pharse.gibraltar}</option>
              <option value="GR">{$pharse.greece}</option>
              <option value="GL">{$pharse.greenland}</option>
              <option value="GD">{$pharse.grenada}</option>
              <option value="GP">{$pharse.guadeloupe}</option>
              <option value="GU">{$pharse.guam}</option>
              <option value="GT">{$pharse.guatemala}</option>
              <option value="GN">{$pharse.guinea}</option>
              <option value="GW">{$pharse.guinea-bissau}</option>
              <option value="GY">{$pharse.guyana}</option>
              <option value="HT">{$pharse.haiti}</option>
              <option value="HM">{$pharse.heard_and_mc_donald_islands}</option>
              <option value="HN">{$pharse.honduras}</option>
              <option value="HK">{$pharse.hong_kong}</option>
              <option value="HU">{$pharse.hungary}</option>
              <option value="IS">{$pharse.iceland}</option>
              <option value="IN">{$pharse.india}</option>
              <option value="ID">{$pharse.indonesia}</option>
              <option value="IR">{$pharse.iran_(islamic_republic_of)}</option>
              <option value="IQ">{$pharse.iraq}</option>
              <option value="IE">{$pharse.ireland}</option>
              <option value="IL">{$pharse.israel}</option>
              <option value="IT">{$pharse.italy}</option>
              <option value="JM">{$pharse.jamaica}</option>
              <option value="JP">{$pharse.japan}</option>
              <option value="JO">{$pharse.jordan}</option>
              <option value="KZ">{$pharse.kazakhstan}</option>
              <option value="KE">{$pharse.kenya}</option>
              <option value="KI">{$pharse.kiribati}</option>
              <option value="KP">{$pharse.north_korea}</option>
              <option value="KR">{$pharse.korea,_republic_of}</option>
              <option value="KW">{$pharse.kuwait}</option>
              <option value="KG">{$pharse.kyrgyzstan}</option>
              <option value="LA">{$pharse.lao_people's_democratic_republic}</option>
              <option value="LV">{$pharse.latvia}</option>
              <option value="LB">{$pharse.lebanon}</option>
              <option value="LS">{$pharse.lesotho}</option>
              <option value="LR">{$pharse.liberia}</option>
              <option value="LY">{$pharse.libyan_arab_jamahiriya}</option>
              <option value="LI">{$pharse.liechtenstein}</option>
              <option value="LT">{$pharse.lithuania}</option>
              <option value="LU">{$pharse.luxembourg}</option>
              <option value="MO">{$pharse.macau}</option>
              <option value="MK">{$pharse.macedonia}</option>
              <option value="MG">{$pharse.madagascar}</option>
              <option value="MW">{$pharse.malawi}</option>
              <option value="MY">{$pharse.malaysia}</option>
              <option value="MV">{$pharse.maldives}</option>
              <option value="ML">{$pharse.mali}</option>
              <option value="MT">{$pharse.malta}</option>
              <option value="MH">{$pharse.marshall_islands}</option>
              <option value="MQ">{$pharse.martinique}</option>
              <option value="MR">{$pharse.mauritania}</option>
              <option value="MU">{$pharse.mauritius}</option>
              <option value="YT">{$pharse.mayotte}</option>
              <option value="MX">{$pharse.mexico}</option>
              <option value="FM">{$pharse.micronesia,_federated_states_of}</option>
              <option value="MD">{$pharse.moldova,_republic_of}</option>
              <option value="MC">{$pharse.monaco}</option>
              <option value="MN">{$pharse.mongolia}</option>
              <option value="MS">{$pharse.montserrat}</option>
              <option value="MA">{$pharse.morocco}</option>
              <option value="MZ">{$pharse.mozambique}</option>
              <option value="MM">{$pharse.myanmar}</option>
              <option value="NA">{$pharse.namibia}</option>
              <option value="NR">{$pharse.nauru}</option>
              <option value="NP">{$pharse.nepal}</option>
              <option value="NL">{$pharse.netherlands}</option>
              <option value="AN">{$pharse.netherlands_antilles}</option>
              <option value="NC">{$pharse.new_caledonia}</option>
              <option value="NZ">{$pharse.new_zealand}</option>
              <option value="NI">{$pharse.nicaragua}</option>
              <option value="NE">{$pharse.niger}</option>
              <option value="NG">{$pharse.nigeria}</option>
              <option value="NU">{$pharse.niue}</option>
              <option value="NF">{$pharse.norfolk_island}</option>
              <option value="MP">{$pharse.northern_mariana_islands}</option>
              <option value="NO">{$pharse.norway}</option>
              <option value="OM">{$pharse.oman}</option>
              <option value="PK">{$pharse.pakistan}</option>
              <option value="PW">{$pharse.palau}</option>
              <option value="PA">{$pharse.panama}</option>
              <option value="PG">{$pharse.papua_new_guinea}</option>
              <option value="PY">{$pharse.paraguay}</option>
              <option value="PE">{$pharse.peru}</option>
              <option value="PH">{$pharse.philippines}</option>
              <option value="PN">{$pharse.pitcairn}</option>
              <option value="PL">{$pharse.poland}</option>
              <option value="PT">{$pharse.portugal}</option>
              <option value="PR">{$pharse.puerto_rico}</option>
              <option value="QA">{$pharse.qatar}</option>
              <option value="RE">{$pharse.reunion}</option>
              <option value="RO">{$pharse.romania}</option>
              <option value="RU">{$pharse.russian_federation}</option>
              <option value="RW">{$pharse.rwanda}</option>
              <option value="KN">{$pharse.saint_kitts_and_nevis}</option>
              <option value="LC">{$pharse.saint_lucia}</option>
              <option value="VC">{$pharse.saint_vincent_and_the_grenadines}</option>
              <option value="WS">{$pharse.samoa}</option>
              <option value="SM">{$pharse.san_marino}</option>
              <option value="ST">{$pharse.sao_tome_and_principe}</option>
              <option value="SA">{$pharse.saudi_arabia}</option>
              <option value="SN">{$pharse.senegal}</option>
              <option value="SC">{$pharse.seychelles}</option>
              <option value="SL">{$pharse.sierra_leone}</option>
              <option value="SG">{$pharse.singapore}</option>
              <option value="SK">{$pharse.slovak_republic}</option>
              <option value="SI">{$pharse.slovenia}</option>
              <option value="SB">{$pharse.solomon_islands}</option>
              <option value="SO">{$pharse.somalia}</option>
              <option value="ZA">{$pharse.south_africa}</option>
              <option value="GS">{$pharse.south_georgia} &amp; {$pharse.south_sandwich_islands}</option>
              <option value="ES">{$pharse.spain}</option>
              <option value="LK">{$pharse.sri_lanka}</option>
              <option value="SH">{$pharse.st._helena}</option>
              <option value="PM">{$pharse.st._pierre_and_miquelon}</option>
              <option value="SD">{$pharse.sudan}</option>
              <option value="SR">{$pharse.suriname}</option>
              <option value="SJ">{$pharse.svalbard_and_jan_mayen_islands}</option>
              <option value="SZ">{$pharse.swaziland}</option>
              <option value="SE">{$pharse.sweden}</option>
              <option value="CH">{$pharse.switzerland}</option>
              <option value="SY">{$pharse.syrian_arab_republic}</option>
              <option value="TW">{$pharse.taiwan}</option>
              <option value="TJ">{$pharse.tajikistan}</option>
              <option value="TZ">{$pharse.tanzania,_united_republic_of}</option>
              <option value="TH">{$pharse.thailand}</option>
              <option value="TG">{$pharse.togo}</option>
              <option value="TK">{$pharse.tokelau}</option>
              <option value="TO">{$pharse.tonga}</option>
              <option value="TT">{$pharse.trinidad_and_tobago}</option>
              <option value="TN">{$pharse.tunisia}</option>
              <option value="TR">{$pharse.turkey}</option>
              <option value="TM">{$pharse.turkmenistan}</option>
              <option value="TC">{$pharse.turks_and_caicos_islands}</option>
              <option value="TV">{$pharse.tuvalu}</option>
              <option value="UG">{$pharse.uganda}</option>
              <option value="UA">{$pharse.ukraine}</option>
              <option value="AE">{$pharse.united_arab_emirates}</option>
              <option value="GB">{$pharse.united_kingdom}</option>
              <option value="US">{$pharse.united_states}</option>
              <option value="UM">{$pharse.united_states_minor_outlying_islands}</option>
              <option value="UY">{$pharse.uruguay}</option>
              <option value="UZ">{$pharse.uzbekistan}</option>
              <option value="VU">{$pharse.vanuatu}</option>
              <option value="VA">{$pharse.vatican_city_state_(holy_see)}</option>
              <option value="VE">{$pharse.venezuela}</option>
              <option value="VN">{$pharse.viet_nam}</option>
              <option value="VG">{$pharse.virgin_islands_(british)}</option>
              <option value="VI">{$pharse.virgin_islands_(u.s.)}</option>
              <option value="WF">{$pharse.wallis_and_futuna_islands}</option>
              <option value="EH">{$pharse.western_sahara}</option>
              <option value="YE">{$pharse.yemen}</option>
              <option value="YU">{$pharse.yugoslavia}</option>
              <option value="CD">{$pharse.democratic_republic_of_congo}</option>
              <option value="ZM">{$pharse.zambia}</option>
              <option value="ZW">{$pharse.zimbabwe}</option>
            </select>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="form-group">
          <label for="inputEmail" class="col-md-4" >{pharse.state:}</label>
          <div class="col-md-8">
            <input type="text" id="state" name="state" placeholder="Enter state" class="form-control" value="{$shipping.state}" title="State" maxlength="20" required>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="form-group">
          <label for="inputEmail" class="col-md-4" >{$pharse.city:}</label>
          <div class="col-md-8">
            <input type="text" id="town" name="city" placeholder="Enter city" class="form-control" value="{$shipping.city}" title="city" maxlength="20" required>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="form-group">
          <label for="inputEmail" class="col-md-4" >{$pharse.zipcode:}</label>
          <div class="col-md-8">
            <input type="text" id="zipcode" name="zipcode" placeholder="Enter zipcode" class="form-control" value="{$shipping.zipcode}" title="Zipcode" maxlength="10" required>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="form-group">
          <label for="inputEmail" class="col-md-4" >{$pharse.phone_number:}</label>
          <div class="col-md-8">
            <input type="text" id="phone" name="phone" placeholder="Eg: 0123123456, +919874563210" class="form-control"  value="{$shipping.phone}" title="Phone Number" maxlength="20" required>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-2">
          <button class="btn save_btn" type="submit">{$pharse.save}</button>
        </div>
      </div>
    </form>
  </div>
</div>
{include file="common/footer-1.tpl" nocache} 
<script>
$(function()
{
	var ctry = '{$shipping.country}';
	if(ctry !='')
	$('#country').val(ctry);
});
</script> 
