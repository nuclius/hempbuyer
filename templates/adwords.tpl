<!--============================================================================*\
|| ########################################################################## ||
|| # Auction Software Marketplace[*]version[*] Build [*]build[*]
|| # ---------------------------------------------------------------------- # ||
|| # Customer License # [*]license[*]
|| # ---------------------------------------------------------------------- # ||
|| # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
|| # This file may not be redistributed in whole or significant part.       # ||
|| # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
|| # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
|| # ---------------------------------------------------------------------- # ||
|| ########################################################################## ||
\*============================================================================ -->

{if $adwords|count > 0}

<div class="panel panel-default animated fadeInDown animation-delay-4">
    <div class="panel-heading"><i class="fa fa-align-left"></i> {$phrase.ads}</div>
    <div class="panel-body">
        <div class="add_words">
            {foreach $adwords as $key => $val}
            <div>
                <a class="pull-left call_controller" style="width: 100%;text-align: center;margin-bottom: 8px; padding-right: 0;" href="#" onclick="goto_ads({$val.id})"><img alt="Advertisement" class="media-object" height="60" src="{$config.url}/uploads/ad_image/{$val.banner}" width="60"></a>
                <div>
                    <p class="media-heading ad_heading" style="margin-bottom: 0;">
                        <a href="#"></a>
                        <a class="call_controller" href="#"  onclick="goto_ads({$val.id})">{$val.ad_title}</a>
                    </p>
                    <!-- <p><small></small></p> -->
                    <small>{dateFormat($val.created_at, 'dd mmmm yyyy')}</small>
                </div> 
            </div>
            
            {/foreach}
            {if $adwords|count == 5}
            <div class="col-md-12 text-right">

                <a href="{$config.url}/adwords/show_all_adwords/{$page_name}">>> Show all </a>
                </div>
            {/if}

        </div>
    </div>
</div>

{/if}
