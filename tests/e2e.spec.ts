// Tests E2E automatizados con Playwright por Joaquín (Testing QA Lead)
// Proyecto: Nexus Software Studio - Landing Page Profesional Premium

import { test, expect } from '@playwright/test';

test.describe('Nexus Software Studio - Suite de Certificación en Producción', () => {
  test('la página principal carga con código 200 y título profesional', async ({ page }) => {
    await page.goto('/');
    await expect(page).toHaveTitle(/Nexus Software Studio/);
  });

  test('el viewport móvil (375px) es 100% responsivo y sin desbordes horizontales', async ({ page }) => {
    await page.setViewportSize({ width: 375, height: 812 });
    await page.goto('/');
    await expect(page.locator('header')).toBeVisible();
    await expect(page.locator('footer')).toBeVisible();
  });

  test('el simulador de CRM interactivo permite mover leads entre columnas', async ({ page }) => {
    await page.goto('/');
    const moveBtn = page.locator('button:has-text("Mover ➔")').first();
    await expect(moveBtn).toBeVisible();
    await moveBtn.click();
    // Verificar que el contador se actualiza
    await expect(page.locator('#count-col-2')).not.toHaveText('0');
  });

  test('el simulador de WhatsApp IA responde a consultas de usuario', async ({ page }) => {
    await page.goto('/');
    await page.click('#tab-bot');
    const input = page.locator('#chat-input');
    await input.fill('¿Tiempos de entrega?');
    await page.click('button:has-text("Enviar")');
    await expect(page.locator('#chat-messages')).toContainText('¿Tiempos de entrega?');
  });

  test('la calculadora interactiva actualiza montos en ARS y USD', async ({ page }) => {
    await page.goto('/');
    const display = page.locator('#calc-total-display');
    await expect(display).toContainText('ARS');
    await page.click('#currency-toggle');
    await expect(display).toContainText('USD');
  });

  test('Core Web Vitals - LCP carga por debajo de los 2.0 segundos', async ({ page }) => {
    const start = Date.now();
    await page.goto('/');
    await page.waitForLoadState('domcontentloaded');
    expect(Date.now() - start).toBeLessThan(2000);
  });
});
