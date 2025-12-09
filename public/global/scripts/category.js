function paddingMake(ulElement,paddingValue){
	paddingValue+=10;
	
	$(ulElement).children('li').each(function(i,liElement){
		if($(liElement).children('i').css("margin-left").substr(0,1)=="0")
			$(liElement).children('i').css("margin-left", paddingValue + "px");
		
		if($(liElement).children('ul').length>0){
			
			paddingMake($(liElement).children('ul'),paddingValue);
		}
	})
}
function iconMakeOpen(liElement)
{
	$(liElement).children("i").addClass("fa-chevron-down");
	$(liElement).children("i").removeClass("fa-chevron-right");
}
function hideShowSubCategory(ulElement)
{
		if($(ulElement).parent().hasClass("open"))
		{
			$(ulElement).show();
		}else{
			$(ulElement).hide();
		}
		$(ulElement).children('li').each(function(i,liElement){
			if($(liElement).children('ul').length>0){
				
				hideShowSubCategory($(liElement).children('ul'));
			}
		});
		
	
}
function activeMake(activeLi){
	// console.log(activeLi);
	if(activeLi.get(0).tagName=="LI"){
		activeLi.parent().parent().addClass("open");
		iconMakeOpen(activeLi.parent().parent());
		activeMake(activeLi.parent().parent());
		
	}
	//active1Make(activeLi.parent().parent());
}

var categoryTree = function () {
    if($(".sidebar-categories-tree li.active").length>0)
		activeMake($(".sidebar-categories-tree li.active"));
	$('.sidebar-categories-tree > li').each(function (i,liElement) {
		if($(liElement).children('ul').length>0)
		{
			hideShowSubCategory($(liElement).children('ul'));
			paddingMake($(liElement).children('ul'),0);
		}
		//console.log($(liElement).children('ul').length,liElement);
	});
	$('.sidebar-categories-tree i').click(function () {
		if($(this).parent().hasClass("open")) {
			$(this).parent().removeClass("open")
			$(this).removeClass("fa-chevron-down");
			$(this).addClass("fa-chevron-right");
			$(this).parent().children('ul').slideUp();
		}else{
			$(this).parent().addClass("open")
			$(this).addClass("fa-chevron-down");
			$(this).removeClass("fa-chevron-right");
			$(this).parent().children("ul").slideDown();
		}
	});
	$('.sidebar-categories-tree a').on('click', function () {
		var search = '';
		var categoryNo = $(this).attr('id');
		var categoryName = $(this).attr('value');
		var currentPage = parseInt($('.pagination li.active a.real-page').attr('data-page'));

		$('.category-name').text(categoryName);
		$('.sidebar-categories-tree li').removeClass('active');
		$('.sidebar-categories-tree li a').removeClass('active');
		$(this).parent().addClass('active');
		$(this).addClass('active');
	});
};

$(document).ready(function() {
	categoryTree();
});

$(document).ready(function(e){
	var walk_ids = [];

	updateList(current_id, 0);

	$(document).on('click', '#categories_list .list-item', function(e){
		if ($(this).find('.fa-angle-right').length == 0) {
			$('#categories_list .list-title').removeClass('active');
			$('#categories_list .list-item').removeClass('active');
			$(this).addClass('active');
			return ;
		}
		walk_ids.push(current_id);
		$('#categories_list .list-title').addClass('active');
		var update_id = $(this).attr('data-id');
		updateList(update_id, update_id);
	});

	$(document).on('click', '#categories_list .list-title', function(e){
		e.preventDefault();
		$('#categories_list .list-item').removeClass('active');
		$('#categories_list .list-title').removeClass('active');
		if (walk_ids.length == 0) {
			if (!$('#categories_list .list-title').hasClass('active'))
				$('#categories_list .list-title').addClass('active');
			return ;
		}

		var update_id = walk_ids.pop();
		var cid = $(this).find('div').attr('data-id');
		updateList(update_id, cid);
	});

	function updateList(update_id, cid) {
		current_id = update_id;
		if (update_id == ROOT_CATEGORY) {
			if (cid == 0)
				clearTitle(update_id, 0);
			else
				clearTitle(update_id, 1);
			makeList(category_data, cid);
		} else {
			var sel_data = getObjects(category_data, 'id', update_id);
			if (sel_data.length > 0) {
				sel_data = sel_data[0];
				if (sel_data.childs && sel_data.childs.length > 0) {
					changeTitle(update_id, sel_data.name);
					makeList(sel_data.childs, cid);
				}
			}
		}
	}

	function changeTitle(id, name) {
		var LIST_TITLE_DOM = '<div style="width:100%;height:100%;" onclick="categoryClick(' + id + ', \'' + name + '\');" data-id="' + id + '"><i class="fa fa-angle-left"></i><label>{ITEM_NAME}</label></div>';
		var dom_title = $('#categories_list .list-title');
		dom_title.attr('data-id', id);
		//dom_title.addClass('active');
		var result = LIST_TITLE_DOM.replaceAll('{ITEM_NAME}', name);
		dom_title.html(result);
	}

	function clearTitle(id, unselected) {
		$('#categories_list .list-title').html('<div style="width:100%;height:100%;" onclick="categoryClick(' + id + ', \'전체\');" data-id="' + id + '"><label>전체</lebel></div>');
		$('#categories_list .list-title').attr('data-id', id);

		if (unselected == 0) {
			if (!$('#categories_list .list-title').hasClass('active'))
				$('#categories_list .list-title').addClass('active');
		}
	}

	function makeList(data, cid) {
		var result = '';
		var LIST_ITEM_DOM = '<div class="list-item category {ITEM_ACTIVE}" onclick="categoryClick({ITEM_ID}, \'{ITEM_NAME}\', \'{ITEM_URL}\')" data-id="{ITEM_ID}" data-children="{ITEM_CHILDREN}"><label>{ITEM_NAME}</label>{ITEM_ARROW}</div>';
		var LIST_ARROW_DOM = '<i class="fa fa-angle-right"></i>';

		for (var i = 0; i < data.length; i++)
		{
			var item = LIST_ITEM_DOM.replaceAll('{ITEM_ID}', data[i].id);
			item = item.replaceAll('{ITEM_NAME}', data[i].name);
			//console.log(current_id + ":" + data[i].id);
			if (cid == data[i].id)
				item = item.replaceAll('{ITEM_ACTIVE}', 'active');
			else
				item = item.replaceAll('{ITEM_ACTIVE}', '');		

			if (typeof(data[i].categoryURL) != 'undefined')
				item = item.replaceAll('{ITEM_URL}', data[i].categoryURL);
			else {
				item = item.replaceAll('{ITEM_URL}', '');
			}

			if (data[i].childs && data[i].childs.length > 0) {
				item = item.replaceAll('{ITEM_ARROW}', LIST_ARROW_DOM);
				item = item.replaceAll('{ITEM_CHILDREN}', data[i].childs.length);
			} else {
				item = item.replaceAll('{ITEM_ARROW}', '');
				item = item.replaceAll('{ITEM_CHILDREN}', 0);
			}
			result += item;
		}
		$('#categories_list .list-body').html(result);
	}

	function getObjects(obj, key, val) {
		var objects = [];
		for (var i in obj) {
			if (!obj.hasOwnProperty(i)) continue;
			if (typeof obj[i] == 'object') {
				objects = objects.concat(getObjects(obj[i], key, val));
			} else if (i == key && obj[key] == val) {
				objects.push(obj);
			}
		}
		return objects;
	}
});

String.prototype.replaceAll = function(search, replacement) {
	var target = this;
	return target.replace(new RegExp(search, 'g'), replacement);
};