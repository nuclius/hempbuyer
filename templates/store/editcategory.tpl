{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
<div class="container-fluid store-head add-prdt">
    <div class="container">
        <div class="col-md-12">
            <div class="col-md-12 con">
                <h2>Create New Products</h2>
                <div class="col-md-12">
                    <h5>Choose Your Category </h5>
                    <div class="col-md-12 padboth">
                        <div class="col-md-12 padlr add-prdt1">
                            <div class="radio-inline">
                                <label>
                                    <input type="checkbox" name="tab" value="" onclick="" />
                                    <span>All</span>
                                </label>
                            </div>
                            {foreach $allcategories as $avl => $val}
                            {if $val.parent_id == 0}
                            <div class="radio-inline">
                                <label>
                                    <input type="checkbox" name="tab" value="{$val.id}" onclick="" />
                                    <span>{$val.name}</span>
                                </label>
                            </div>
                            {/if}
                            {/foreach}
                            <div class="col-md-12 padboth padlr">
                                <button class="btn btn-default" onclick="location.href='add-new-product-next-store.html'">Next</button>
                            </div>
                        </div>
                        <div class="col-md-12 padboth padlr">
                            <div id="div1">
                                <h5>Choose Sub  Category </h5>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="Sub" value="" /> Single Track</label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="Sub" value="" />Multiple Tracks (e.g. Album)</label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="Sub" value="" />Royalty-Free Single Track</label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="Sub" value="" />Royalty-Free Multiple Tracks (e.g. Album)</label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="Sub" value="" />Audio Library (.zip file)</label>
                                </div>
                                <div class="col-md-12 padboth padlr">
                                    <button class="btn btn-default" onclick="location.href='add-new-product-next-store.html'">Next</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function show1() {
        document.getElementById('div2').style.display = 'none';
        document.getElementById('div3').style.display = 'none';
        document.getElementById('div4').style.display = 'none';
        document.getElementById('div5').style.display = 'none';
        document.getElementById('div6').style.display = 'none';
        document.getElementById('div1').style.display = 'block';
    }

</script>
{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}
