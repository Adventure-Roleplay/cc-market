window.addEventListener('message', function(event) {
    if (event.data.action === 'openMarket') {
        openMarket(event.data.items);
    } else if (event.data.action === 'closeMarket') {
        closeMarket();
    } else if (event.data.action === 'updatePrices') {
        updatePrices(event.data.items);
    }
});

function openMarket(items) {
    const marketDiv = document.getElementById('marketContainer');
    const itemsDiv = document.getElementById('items');
    itemsDiv.innerHTML = '';

    items.forEach(item => {
        const itemDiv = createItemElement(item);
        itemsDiv.appendChild(itemDiv);
    });

    marketDiv.style.display = 'flex';
}

function updatePrices(items) {
    const itemsDiv = document.getElementById('items');
    itemsDiv.innerHTML = '';

    items.forEach(item => {
        const itemDiv = createItemElement(item);
        itemsDiv.appendChild(itemDiv);
    });
}

function createItemElement(item) {
    const itemDiv = document.createElement('li');
    itemDiv.className = 'item';
    itemDiv.dataset.itemName = item.name;

    const img = document.createElement('img');
    img.src = `nui://ox_inventory/web/images/${item.name}.png`;

    const detailsDiv = document.createElement('div');
    detailsDiv.className = 'details';

    const nameDiv = document.createElement('div');
    nameDiv.textContent = item.label;

    const priceDiv = document.createElement('div');
    priceDiv.className = 'price';
    const priceChangeFormatted = item.priceChange >= 0 ? `↑ +$${item.priceChange}` : `↓ -$${Math.abs(item.priceChange)}`;
    priceDiv.textContent = `${item.price}$`;
    if (item.priceChange > 0) {
        priceDiv.classList.add('change-up');
    } else if (item.priceChange < 0) {
        priceDiv.classList.add('change-down');
    } else {
        priceDiv.classList.add('no-change');
    }

    const changeDiv = document.createElement('div');
    changeDiv.textContent = priceChangeFormatted;
    if (item.priceChange > 0) {
        changeDiv.style.color = 'green';
    } else if (item.priceChange < 0) {
        changeDiv.style.color = 'red';
    } else {
        changeDiv.style.color = 'white';
    }

    detailsDiv.appendChild(nameDiv);
    detailsDiv.appendChild(priceDiv);
    detailsDiv.appendChild(changeDiv);
    itemDiv.appendChild(img);
    itemDiv.appendChild(detailsDiv);

    return itemDiv;
}

function closeMarket() {
    const marketDiv = document.getElementById('marketContainer');
    marketDiv.style.display = 'none';
    fetch(`https://${GetParentResourceName()}/closeMarket`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({}),
    });
}

document.getElementById('closeButton').addEventListener('click', function() {
    closeMarket();
});

// Add listener for escape key
document.addEventListener('keydown', function(event) {
    if (event.key === "Escape") {
        closeMarket();
    }
});
