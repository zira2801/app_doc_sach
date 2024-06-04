// @ts-nocheck
'use strict';

/**
 * profile controller
 */
const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::profile.profile', ({ strapi }) => ({
  async createMe(ctx) {
    try {
      const user = ctx.state.user;
      if (!user) {
        return ctx.forbidden('No authorized user found');
      }

      const result = await strapi.entityService.create('api::profile.profile', {
        data: {
          fullName: ctx.request.body.fullName,
          email: user.email,
          user: user.id
        },
      });
      return result;
    } catch (err) {
      ctx.internalServerError('Error creating profile');
    }
  },

  async getMe(ctx) {
    try {
      const user = ctx.state.user;
      if (!user) {
        return ctx.forbidden('No authorized user found');
      }

      const result = await strapi.db.query('api::profile.profile').findOne({
        where: {
          user: {
            id: user.id,
          },
        },
        populate: {
          image: true,
        },
      });

      if (!result) {
        return ctx.notFound('Profile not found');
      }

      return result;
    } catch (err) {
      ctx.internalServerError('Error retrieving profile');
    }
  },
}));